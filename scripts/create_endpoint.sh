#!/bin/bash

# Script to create endpoint files for a feature
# Usage: ./create_endpoint.sh

# Function to convert snake_case to UpperCamelCase
to_upper_camel_case() {
    # Split by underscore, capitalize first letter of each part, join
    echo "$1" | awk -F'_' '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1' OFS=''
}

# Function to convert snake_case to lowerCamelCase
to_lower_camel_case() {
    local upper=$(to_upper_camel_case "$1")
    # Lowercase the first character
    echo "${upper}" | awk '{print tolower(substr($0,1,1)) substr($0,2)}'
}

# Function to convert to lower_case (ensure lowercase)
to_lower_case() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

# Function to capitalize first letter of feature name
capitalize_first() {
    echo "$1" | awk '{print toupper(substr($0,1,1)) substr($0,2)}'
}

# Ask for feature name
read -p "Enter feature name (e.g., home, auth, profile): " FEATURE_NAME

if [ -z "$FEATURE_NAME" ]; then
    echo "Error: Feature name is required"
    exit 1
fi

FEATURE_PATH="lib/src/features/$FEATURE_NAME"

# Check if feature exists
if [ ! -d "$FEATURE_PATH" ]; then
    echo "Error: Feature '$FEATURE_NAME' does not exist at $FEATURE_PATH"
    exit 1
fi

# Ask for endpoint name
read -p "Enter endpoint name (snake_case, e.g., fetch_home, create_order): " ENDPOINT_NAME

if [ -z "$ENDPOINT_NAME" ]; then
    echo "Error: Endpoint name is required"
    exit 1
fi

# Convert names
SNAKE_NAME=$(to_lower_case "$ENDPOINT_NAME")
UPPER_CAMEL_NAME=$(to_upper_camel_case "$SNAKE_NAME")
LOWER_CAMEL_NAME=$(to_lower_camel_case "$SNAKE_NAME")
FEATURE_CAPITALIZED=$(capitalize_first "$FEATURE_NAME")

echo ""
echo "Creating endpoint: $SNAKE_NAME"
echo "  UpperCamelCase: $UPPER_CAMEL_NAME"
echo "  lowerCamelCase: $LOWER_CAMEL_NAME"
echo "Feature: $FEATURE_NAME ($FEATURE_CAPITALIZED)"
echo ""

# Create directories if they don't exist
mkdir -p "$FEATURE_PATH/data/data_sources"
mkdir -p "$FEATURE_PATH/domain/repositories"
mkdir -p "$FEATURE_PATH/domain/use_cases"
mkdir -p "$FEATURE_PATH/presentation/controllers"
mkdir -p "$FEATURE_PATH/core/apis"

# Check and add API URL to feature apis file
APIS_FILE="$FEATURE_PATH/core/apis/${FEATURE_NAME}_apis.dart"
API_URL_LINE="  final String url${UPPER_CAMEL_NAME} = \"\${baseUrl}${SNAKE_NAME}\";"

if [ -f "$APIS_FILE" ]; then
    # Check if URL already exists
    if grep -q "url${UPPER_CAMEL_NAME}" "$APIS_FILE"; then
        echo "✓ API URL already exists in $APIS_FILE"
    else
        # Find the last line with 'final String url' and add after it
        # Or add before the closing brace of the class
        if grep -q "final String url" "$APIS_FILE"; then
            # Add after the last url line
            sed -i '' "/final String url.*=.*baseUrl/a\\
$API_URL_LINE
" "$APIS_FILE"
        else
            # Add before the last closing brace
            sed -i '' "/^}$/i\\
$API_URL_LINE
" "$APIS_FILE"
        fi
        echo "✓ Added API URL to $APIS_FILE"
    fi
else
    # Create the apis file
    cat > "$APIS_FILE" << EOF
import '../../../../core/network_structure/api_names.dart';

class ${FEATURE_CAPITALIZED}Apis {
  ${FEATURE_CAPITALIZED}Apis._();

  static String baseUrl = "";

  static ${FEATURE_CAPITALIZED}Apis instance({String? url}) {
    _setBaseUrl(url: url);
    return ${FEATURE_CAPITALIZED}Apis._();
  }

$API_URL_LINE

  static void _setBaseUrl({String? url}) {
    if (url != null && url.isNotEmpty) {
      baseUrl = url;
    }
  }
}
EOF
    echo "✓ Created: $APIS_FILE"
fi

# 1. Create API Service
API_SERVICE_FILE="$FEATURE_PATH/data/data_sources/${SNAKE_NAME}_api_service.dart"
cat > "$API_SERVICE_FILE" << EOF
import 'package:dio/src/response.dart';

import '../../../../core/network_structure/data_source/service_interface.dart';
import '../../../../core/network_structure/params/params.dart';

class ${UPPER_CAMEL_NAME}ApiService extends ServicesInterface {
  ${UPPER_CAMEL_NAME}ApiService._();
  static final instance = ${UPPER_CAMEL_NAME}ApiService._();
  
  @override
  Future<Response> applyService({Params? params}) {
    return super.call(
      ${FEATURE_NAME}Apis.url${UPPER_CAMEL_NAME},
      type: CrudType.post,
      params: params,
      withPagination: false,
      showLoadingDialog: false,
      auth: true,
    );
  }
}
EOF
echo "✓ Created: $API_SERVICE_FILE"

# Ask for response (entity/model) FIRST - we need to know this for repo/usecase/controller
echo ""
read -p "Does this endpoint have a response model? (y/n): " HAS_RESPONSE

if [ "$HAS_RESPONSE" = "y" ] || [ "$HAS_RESPONSE" = "Y" ]; then
    ENTITY_TYPE="${UPPER_CAMEL_NAME}Entity"
    HAS_ENTITY=true
    
    mkdir -p "$FEATURE_PATH/data/models"
    mkdir -p "$FEATURE_PATH/domain/entities"
    
    # Create Entity
    ENTITY_FILE="$FEATURE_PATH/domain/entities/${SNAKE_NAME}_entity.dart"
    cat > "$ENTITY_FILE" << EOF
import '../../../../core/network_structure/entities/entity.dart';

class ${UPPER_CAMEL_NAME}Entity extends Entity {
  int? id;
  String? title;
  
  ${UPPER_CAMEL_NAME}Entity({
    this.id,
    this.title,
  });
  
  @override
  List<Object?> get props => [
    id,
    title,
  ];

  @override
  List<${UPPER_CAMEL_NAME}Entity> get example => [
    ${UPPER_CAMEL_NAME}Entity(
      id: 1,
      title: 'Example',
    )
  ];
}
EOF
    echo "✓ Created: $ENTITY_FILE"
    
    # Create Model
    MODEL_FILE="$FEATURE_PATH/data/models/${SNAKE_NAME}_model.dart"
    cat > "$MODEL_FILE" << EOF
import '../../../../core/utils/extensions/json_parsing_extension.dart';
import '../../../../core/utils/general_utils.dart';
import '../../domain/entities/${SNAKE_NAME}_entity.dart';

class ${UPPER_CAMEL_NAME}Model extends ${UPPER_CAMEL_NAME}Entity {
  ${UPPER_CAMEL_NAME}Model({
    super.id,
    super.title,
  });

  ${UPPER_CAMEL_NAME}Model.fromJson(Map<String, dynamic> json) {
    printDM("=============== ${UPPER_CAMEL_NAME}Model ===============");
    
    id = json.parseInt('id');
    printDM("${UPPER_CAMEL_NAME}Model id: \$id");
    
    title = json.parseString('title');
    printDM("${UPPER_CAMEL_NAME}Model title: \$title");
  }
}
EOF
    echo "✓ Created: $MODEL_FILE"
else
    ENTITY_TYPE="void"
    HAS_ENTITY=false
fi

# 2. Create Repository
REPO_FILE="$FEATURE_PATH/domain/repositories/${SNAKE_NAME}_repo.dart"

if [ "$HAS_ENTITY" = true ]; then
    cat > "$REPO_FILE" << EOF
import '../../../../core/network_structure/data_source/service_interface.dart';
import '../../../../core/network_structure/repository/repo_interface.dart';
import '../../data/data_sources/${SNAKE_NAME}_api_service.dart';
import '../../data/models/${SNAKE_NAME}_model.dart';
import '../entities/${SNAKE_NAME}_entity.dart';

class ${UPPER_CAMEL_NAME}Repo extends RepoInterface<${UPPER_CAMEL_NAME}Entity> {

  ${UPPER_CAMEL_NAME}Repo._();
  static final ${UPPER_CAMEL_NAME}Repo instance = ${UPPER_CAMEL_NAME}Repo._();
  
  @override
  ${UPPER_CAMEL_NAME}Entity Function(dynamic data) get onParse => (data) {
        return ${UPPER_CAMEL_NAME}Model.fromJson(data);
      };

  @override
  ServicesInterface get serviceInstance => ${UPPER_CAMEL_NAME}ApiService.instance;

  @override
  ${UPPER_CAMEL_NAME}Entity? get devData => ${UPPER_CAMEL_NAME}Entity().example.first;
  
  @override
  ${UPPER_CAMEL_NAME}Entity? get testData => ${UPPER_CAMEL_NAME}Entity().example.first;
}
EOF
else
    cat > "$REPO_FILE" << EOF
import '../../../../core/network_structure/data_source/service_interface.dart';
import '../../../../core/network_structure/repository/repo_interface.dart';
import '../../data/data_sources/${SNAKE_NAME}_api_service.dart';

class ${UPPER_CAMEL_NAME}Repo extends RepoInterface<void> {

  ${UPPER_CAMEL_NAME}Repo._();
  static final ${UPPER_CAMEL_NAME}Repo instance = ${UPPER_CAMEL_NAME}Repo._();
  
  @override
  ResponseType get responseType => ResponseType.withoutData;
  
  @override
  void Function(dynamic data) get onParse => (data) {};

  @override
  ServicesInterface get serviceInstance => ${UPPER_CAMEL_NAME}ApiService.instance;
}
EOF
fi
echo "✓ Created: $REPO_FILE"

# 3. Create Use Case
USECASE_FILE="$FEATURE_PATH/domain/use_cases/${SNAKE_NAME}_use_case.dart"

if [ "$HAS_ENTITY" = true ]; then
    cat > "$USECASE_FILE" << EOF
import '../../../../core/network_structure/params/params.dart';
import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../super/use_case/user_case.dart';
import '../entities/${SNAKE_NAME}_entity.dart';
import '../repositories/${SNAKE_NAME}_repo.dart';

class ${UPPER_CAMEL_NAME}UseCase extends UseCase<${UPPER_CAMEL_NAME}Entity, NOParams> {
  @override
  Future<DataState<${UPPER_CAMEL_NAME}Entity>>? call({NOParams? params}) {
    return ${UPPER_CAMEL_NAME}Repo.instance.call();
  }
}
EOF
else
    cat > "$USECASE_FILE" << EOF
import '../../../../core/network_structure/params/params.dart';
import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../super/use_case/user_case.dart';
import '../repositories/${SNAKE_NAME}_repo.dart';

class ${UPPER_CAMEL_NAME}UseCase extends UseCase<void, NOParams> {
  @override
  Future<DataState<void>>? call({NOParams? params}) {
    return ${UPPER_CAMEL_NAME}Repo.instance.call();
  }
}
EOF
fi
echo "✓ Created: $USECASE_FILE"

# 4. Create Controller
CONTROLLER_FILE="$FEATURE_PATH/presentation/controllers/${SNAKE_NAME}_controller.dart"

if [ "$HAS_ENTITY" = true ]; then
    cat > "$CONTROLLER_FILE" << EOF
import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../super/controllers/resources/get/get_controller_interface.dart';
import '../../domain/entities/${SNAKE_NAME}_entity.dart';
import '../../domain/use_cases/${SNAKE_NAME}_use_case.dart';

class ${UPPER_CAMEL_NAME}Controller extends GetControllerInterface<${UPPER_CAMEL_NAME}Entity> {

  ${LOWER_CAMEL_NAME}() async {
    emit(const DataLoading());
    var useCase = ${UPPER_CAMEL_NAME}UseCase();

    state = await useCase()!;
    emit(state);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
EOF
else
    cat > "$CONTROLLER_FILE" << EOF
import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../super/controllers/resources/get/get_controller_interface.dart';
import '../../domain/use_cases/${SNAKE_NAME}_use_case.dart';

class ${UPPER_CAMEL_NAME}Controller extends GetControllerInterface<void> {

  Future<void> ${LOWER_CAMEL_NAME}() async {
    emit(DataLoading());
    ${UPPER_CAMEL_NAME}UseCase useCase = ${UPPER_CAMEL_NAME}UseCase();

    state = await useCase()!;
    emit(state);
  }

  @override
  void onInit() {
    super.onInit();
    ${LOWER_CAMEL_NAME}();
  }
}
EOF
fi
echo "✓ Created: $CONTROLLER_FILE"

# Ask for params
echo ""
read -p "Does this endpoint have params? (y/n): " HAS_PARAMS

if [ "$HAS_PARAMS" = "y" ] || [ "$HAS_PARAMS" = "Y" ]; then
    mkdir -p "$FEATURE_PATH/core/params"
    PARAMS_FILE="$FEATURE_PATH/core/params/${SNAKE_NAME}_params.dart"
    cat > "$PARAMS_FILE" << EOF
import '../../../../core/network_structure/params/params.dart';

class ${UPPER_CAMEL_NAME}Params extends Params {
  final int? id;

  ${UPPER_CAMEL_NAME}Params({
    this.id,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
EOF
    echo "✓ Created: $PARAMS_FILE"
    
    # Update use case to use params
    if [ "$HAS_ENTITY" = true ]; then
        cat > "$USECASE_FILE" << EOF
import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../super/use_case/user_case.dart';
import '../../core/params/${SNAKE_NAME}_params.dart';
import '../entities/${SNAKE_NAME}_entity.dart';
import '../repositories/${SNAKE_NAME}_repo.dart';

class ${UPPER_CAMEL_NAME}UseCase extends UseCase<${UPPER_CAMEL_NAME}Entity, ${UPPER_CAMEL_NAME}Params> {
  @override
  Future<DataState<${UPPER_CAMEL_NAME}Entity>>? call({${UPPER_CAMEL_NAME}Params? params}) {
    return ${UPPER_CAMEL_NAME}Repo.instance.call(params: params);
  }
}
EOF
    else
        cat > "$USECASE_FILE" << EOF
import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../super/use_case/user_case.dart';
import '../../core/params/${SNAKE_NAME}_params.dart';
import '../repositories/${SNAKE_NAME}_repo.dart';

class ${UPPER_CAMEL_NAME}UseCase extends UseCase<void, ${UPPER_CAMEL_NAME}Params> {
  @override
  Future<DataState<void>>? call({${UPPER_CAMEL_NAME}Params? params}) {
    return ${UPPER_CAMEL_NAME}Repo.instance.call(params: params);
  }
}
EOF
    fi
    echo "✓ Updated: $USECASE_FILE (with params)"
fi

echo ""
echo "=========================================="
echo "Endpoint '$SNAKE_NAME' created successfully!"
echo "=========================================="
echo ""
echo "Files created:"
echo "  - $API_SERVICE_FILE"
echo "  - $REPO_FILE"
echo "  - $USECASE_FILE"
echo "  - $CONTROLLER_FILE"
if [ "$HAS_PARAMS" = "y" ] || [ "$HAS_PARAMS" = "Y" ]; then
    echo "  - $PARAMS_FILE"
fi
if [ "$HAS_ENTITY" = true ]; then
    echo "  - $ENTITY_FILE"
    echo "  - $MODEL_FILE"
fi
echo ""
echo "Don't forget to:"
echo "  1. Update the imports as needed"
echo "  2. Modify the entity/model fields according to your API response"

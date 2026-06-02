/// Landing-page translation keys for Phase 2.
/// Arabic strings are English placeholders until Phase 5.
/// All visible strings in landing code must use .toTr() with one of these keys.

const Map<String, String> landingEnUS = {
  // ── NavBar ────────────────────────────────────────────────────────────────
  'nav.features': 'Features',
  'nav.how_it_works': 'How it works',
  'nav.for_clinicians': 'For clinicians',
  'nav.pricing': 'Pricing',
  'nav.faq': 'FAQ',
  'nav.cta.demo': 'Book a demo',
  'nav.menu.open': 'Open menu',
  'nav.menu.close': 'Close menu',
  'nav.language.switch': 'Switch language',

  // ── Hero ──────────────────────────────────────────────────────────────────
  'hero.eyebrow': 'Healthcare, reimagined',
  'hero.headline': 'One platform for every clinic and every patient.',
  'hero.headline.emph': 'every patient',
  'hero.subheadline':
      'Streamline appointments, records, and care coordination — built for the modern medical practice.',
  'hero.cta.primary': 'Book a demo',
  'hero.cta.secondary': 'See how it works',
  'hero.trust': 'Trusted by 250+ clinics across the region',

  // ── Footer — columns ─────────────────────────────────────────────────────
  'footer.column.product': 'Product',
  'footer.column.company': 'Company',
  'footer.column.resources': 'Resources',

  'footer.link.features': 'Features',
  'footer.link.how_it_works': 'How it works',
  'footer.link.pricing': 'Pricing',

  'footer.link.about': 'About',
  'footer.link.contact': 'Contact',
  'footer.link.careers': 'Careers',

  'footer.link.help': 'Help center',
  'footer.link.privacy': 'Privacy',
  'footer.link.terms': 'Terms',

  // ── Footer — bottom strip ─────────────────────────────────────────────────
  'footer.copyright': '© {year} BrandName. All rights reserved.',

  // ── Placeholders ──────────────────────────────────────────────────────────
  'section.coming_soon': 'COMING SOON',

  // ── Footer brand tagline (separate from hero eyebrow) ────────────────────
  'footer.tagline':
      'A modern medical platform connecting clinics, clinicians, and patients.',
};

/// Arabic placeholder — same as English until Phase 5.
const Map<String, String> landingArAE = landingEnUS;

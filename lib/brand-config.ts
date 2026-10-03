/**
 * NineU Labs Brand Asset Configuration
 * Centralized brand asset references for use across the entire ecosystem.
 * Do not modify asset locations or recreate assets from code.
 */

export const brandAssets = {
  // Primary wide logo for website headers and desktop
  logoWide: '/brand/logo-wide-official.png',
  logoWideAlt: 'NineU Labs',
  logoWideWidth: 300,
  logoWideHeight: 100,

  // Square logo for mobile, app icons, and profile contexts
  logoSquare: '/brand/logo-square-official.png',
  logoSquareAlt: 'NineU Labs',
  logoSquareSize: 256,

  // NU monogram for compact/mobile/favicon usage
  logoMonogram: '/brand/logo-nu-monogram-official.png',
  logoMonogramAlt: 'NU',
  logoMonogramSize: 128,

  // Brand color palette
  colors: {
    navy950: '#020b1c',
    navy900: '#071d3a',
    blue700: '#0f5cc7',
    cyan: '#35e2ff',
    blue: '#1f5fff',
    white: '#eef7ff'
  },

  // Brand messaging
  tagline: 'BUILDING THE FUTURE WITH INTELLIGENT TECHNOLOGY',
  pillars: ['AI', 'SOFTWARE', 'CLOUD', 'INNOVATION']
};

/**
 * Usage examples:
 *
 * In Next.js components:
 * import { brandAssets } from '@/lib/brand-config';
 *
 * export default function Header() {
 *   return (
 *     <img
 *       src={brandAssets.logoWide}
 *       alt={brandAssets.logoWideAlt}
 *       width={brandAssets.logoWideWidth}
 *       height={brandAssets.logoWideHeight}
 *     />
 *   );
 * }
 */

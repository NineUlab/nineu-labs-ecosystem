import './globals.css';
import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'NineU Labs',
  description: 'NineU Labs ecosystem foundation'
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}

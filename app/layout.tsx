import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "LedgerLane | Banking Sandbox",
  description: "A simulated banking workspace for accounts, transfers and transaction history.",
  other: {
    "codex-preview": "development",
  },
  icons: {
    icon: "/favicon.svg",
    shortcut: "/favicon.svg",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className="antialiased">{children}</body>
    </html>
  );
}

export default function HomePage() {
  return (
    <main className="page-shell">
      <section className="hero-panel">
        <div className="hero-glow" />
        <div className="brand-block">
          <div className="brand-title-wrap">
            <span className="brand-name">NineU Labs</span>
            <span className="brand-tagline">BUILDING THE FUTURE WITH INTELLIGENT TECHNOLOGY</span>
          </div>
          <div className="brand-pills" aria-label="Brand pillars">
            <span>AI</span>
            <span>•</span>
            <span>SOFTWARE</span>
            <span>•</span>
            <span>CLOUD</span>
            <span>•</span>
            <span>INNOVATION</span>
          </div>
        </div>
      </section>

      <section className="status-grid">
        <div className="status-card">
          <p className="label">Stage</p>
          <h2>Foundation</h2>
        </div>
        <div className="status-card">
          <p className="label">Architecture</p>
          <h2>Next.js + Supabase</h2>
        </div>
        <div className="status-card">
          <p className="label">Database</p>
          <h2>Schema Ready</h2>
        </div>
      </section>
    </main>
  );
}

# Credit Card Roulette Style Guideline

## 1) Brand Direction
- Keep the UI premium-minimal: calm layout, low clutter, clear hierarchy.
- Preserve existing flow and navigation to keep the app simple.
- Use orange as the single action accent.
- Follow the OS theme automatically (light or dark).

## 2) Design Tokens

### Colors
- Primary accent: `#E77E22` (light), `#F29B4B` (dark).
- Surfaces should stay neutral-warm to avoid visual noise.
- Use accent only for primary actions and key highlights.
- Use `error` color for destructive actions.

### Typography
- `displayLarge`: title moments only.
- `headlineLarge/headlineMedium`: winner and section headers.
- `titleLarge/titleMedium`: button and form labels.
- `bodyLarge/bodyMedium`: supporting text and details.
- Prefer semibold/bold weights over decorative styles.

### Spacing
- `spaceS = 8`
- `spaceM = 16`
- `spaceL = 24`
- Use balanced spacing rhythm: 8/16/24 scale.

### Shape
- `radiusS = 12`
- `radiusM = 18`
- `radiusL = 24`
- Prefer soft rounded corners for cards, inputs, and buttons.

### Motion
- `motionFast = 160ms` for tiny state shifts.
- `motionStandard = 220ms` for transitions.
- Use fade/scale subtly; avoid expressive motion.

## 3) Component Rules (Do / Don't)

### Buttons
- Do: use `FilledButton` for primary actions with large tap targets.
- Do: keep one obvious primary action per section.
- Don't: stack several visually dominant buttons together.
- Don't: use multiple accent colors for actions.

### Cards and Rows
- Do: keep cards flat or very low elevation.
- Do: rely on spacing and typography before borders/shadows.
- Don't: add heavy gradients or bright decorative fills.

### Inputs
- Do: use rounded outlined fields with clear focus state.
- Do: keep labels short and direct.
- Don't: mix many border styles in the same screen.

### Feedback and States
- Do: use neutral helper text and orange for emphasis.
- Do: reserve red (`error`) for destructive or invalid states.
- Don't: use strong color coding for non-critical messages.

## 4) Screen Mapping (Roulette Screen)
- Keep the wheel as the central visual element.
- Use muted section colors with one accent segment for a premium feel.
- Keep countdown animation subtle (`220ms`).
- Preserve current flow: spin/countdown -> winner reveal -> play again button.
- Keep winner typography high contrast and easy to scan.

## 5) Accessibility Baseline
- Maintain text/background contrast at WCAG AA minimum.
- Ensure all interactive targets are at least 48x48 logical pixels.
- Avoid conveying critical meaning with color alone.
- Support system text scaling without clipping key actions.
- Verify readability in both system light and dark themes.

## 6) Visual QA Checklist (Release)
- [ ] App follows system light/dark theme correctly.
- [ ] Accent usage is consistent (primary actions only).
- [ ] Buttons, cards, and inputs use consistent corner radius.
- [ ] Spacing follows 8/16/24 rhythm with no crowded sections.
- [ ] Primary actions remain clear on each screen.
- [ ] Winner state is readable in both themes.
- [ ] Destructive actions use error color consistently.
- [ ] All tap targets meet minimum size requirements.

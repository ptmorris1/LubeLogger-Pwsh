# Copilot Working Rules for LubeLogger-Pwsh

When generating or editing PowerShell functions in public/, always follow:
- .github/instructions/lubelogger-api-wrapper.instructions.md

Authentication standard for all API wrapper functions:
- Use BaseUrl plus one auth parameter set only.
- ApiKey parameter set: -ApiKey
- Credential parameter set: -Credential ([PSCredential])
- Never require both ApiKey and Credential at the same time.

Implementation expectations:
- Normalize BaseUrl with TrimEnd('/').
- Build endpoint URLs under /api/.
- Return PSCustomObject with Url, StatusCode, StatusMessage, Success, and payload property.
- Use Invoke-WebRequest with -ErrorAction Stop.
- Include comment-based help with generic examples only (no personal usernames or values).

## Working Preferences for LubeLogger-Pwsh Development

- **Assume Windows platform** when discussing PowerShell and module structure.
- **Prefer simple solutions first** — avoid overengineering or gold-plating.
- **Use PowerShell examples by default** for all guidance and documentation.
- **Do not add extra features, scaffolding, refactors, or dependencies unless explicitly requested.**
- **When editing code**, make the smallest necessary change and preserve existing structure.
- **When suggesting module structure**, keep it practical and minimal.
- **When suggesting git steps**, explain them simply and one step at a time.

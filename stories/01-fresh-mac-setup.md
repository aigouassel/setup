# Story 1: Fresh Mac Setup (Happy Path)

## User Story

**As a** developer with a fresh Mac
**I want to** run a single setup script
**So that** my entire development environment is configured automatically

## Acceptance Criteria

- [ ] Only requirement is git installed
- [ ] Clone repo → run `./setup.sh` → delete repo
- [ ] All tools and configs are installed and working
- [ ] No manual configuration needed after script completes

## Workflow

1. Fresh Mac with only git installed
2. Clone this repository
3. Run `./setup.sh`
4. Script completes with all tools installed and configured
5. Delete repository (no longer needed)
6. Environment is ready to use

## Success Criteria

After running the script:
- Development environment is fully configured
- All packages are installed
- Shell is configured with Oh-My-Zsh and Starship
- Git is configured with user settings
- Custom aliases are available
- No errors or manual steps required

---
paths:
  - "packages/library_bloc/**"
  - "packages/library_riverpod/**"
---

# Parity

Both apps are the same app. Any behaviour added to one must exist and behave the same in the other.

# Dependency injection at the root

Both apps receive the same objects from `app/` and expose them through their own mechanism, so they stay comparable:

- `app/lib/configure_environment.dart` builds a `library_core` `Environment` and both `main_*.dart` files pass it to their app's constructor.
- `BlocLibraryApp` exposes it with `MultiRepositoryProvider` / `RepositoryProvider.value`.
- `RiverpodLibraryApp` overrides `environmentProvider` (`lib/src/core/environment_provider.dart`) in its `ProviderScope`. The provider throws `UnimplementedError` by default, so it must be overridden.

When something new is shared at the root (e.g. a `NetworkManager` or a repository), it should follow the same pattern in both apps.

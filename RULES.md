# Strict Starsector Modding Guardrails

## 1. Language & Runtime Constraints
- **Java Version**: Target Java 7 syntax strictly (or Java 8 if utilizing the unofficial community JRE update). 
- Do NOT use modern Java features (no `var` keywords, no advanced streams, no diamond operators if targeting base Java 7).
- Never introduce external dependencies unless they are explicitly placed in the `/jars` folder.

## 2. Memory & Lifecycles
- **Memory Leaks**: Do NOT save references to `ShipAPI`, `CombatEngineAPI`, or `SectorEntityToken` inside long-lived static variables or persistent scripts. They cause massive memory leaks when reloading saves or switching combats.
- **Transience**: Mark all complex runtime objects that shouldn't be saved to the `campaign.xml` file as `transient`.

## 3. Data Integrity
- Never mutate the game's core data tables directly unless copying the data structure first.
- Modifying `mod_info.json` must preserve strict JSON formatting without comments.

## 4. Performance and overhead
- Always assume that anything coming from the Starsector API can always become null for no obvious/apparent reason
- If using kotlin, never make methods accept non-nullable types if they are DIRECTLY working with starsector API. If they are accepting return values from our own code, always prefer strict typing
- Always prefer working on copies of data (such as lists, sets, etc) that are coming from the Starsector API to avoid accidental ConcurrentModificationExceptions or NullPointerExceptions
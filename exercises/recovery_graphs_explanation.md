### Question:

Calculate the recovery line for the two diagrams below using the rollback-dependency graph for the first one and the checkpoint-dependency graph for the second one. Finally, explain when these kinds of graphs are used and how the data to build them is collected.

---

### Answer:

#### Recovery Line Calculation:
1. **Rollback-Dependency Graph**:
   - From the dependency graph, transform dependencies between intervals into dependencies between checkpoints.
   - Mark nodes corresponding to failure states.
   - Follow arrows from the marked nodes to identify states reachable from them.
   - Remove these marked states and determine the last unmarked checkpoint for each process.
   - The recovery line is defined by these last unmarked checkpoints.

2. **Checkpoint-Dependency Graph**:
   - Start with dependencies between the initial state of the sender interval and the final state of the receiver interval.
   - Identify if a dependency makes the cut inconsistent.
   - If a cut is inconsistent, remove the state receiving the dependency arrow.
   - Continue eliminating dependent states until all remaining checkpoints are independent.
   - The recovery line is defined by the last independent checkpoints for all processes.

---

#### When These Graphs Are Used:
Both graphs are used in **failure recovery** for distributed systems to ensure consistency:
- **Rollback-Dependency Graph**: Suitable for systems with **event logging** to analyze which states or processes must be rolled back.
- **Checkpoint-Dependency Graph**: Useful when **periodic checkpointing** is implemented, ensuring a consistent global state during recovery.

---

#### How Data is Collected:
- **Rollback-Dependency Graph**:
  - Data is collected from **event logs**, which include:
    - Messages exchanged between processes.
    - State transitions and recorded events.
  - Dependency relationships between intervals are derived from these logs.

- **Checkpoint-Dependency Graph**:
  - Data is collected from **checkpoint metadata**, which includes:
    - Timestamps or identifiers of intervals between checkpoints.
    - Information piggybacked with messages, noting interval dependencies.
  - These records are used to build the graph and identify consistent cuts.

Both approaches are crucial for **backward recovery** in distributed systems, ensuring the system is brought back to a consistent state after a failure.
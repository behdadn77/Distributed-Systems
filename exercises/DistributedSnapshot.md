## QA Session around 00:15:00 - Page 80 Final DS Notes


In distributed snapshot algorithms like the **Chandy-Lamport algorithm**, a node stops recording from a channel in the following scenarios:

1. **When it receives a marker on that channel**:  
   When a node receives a marker on a particular incoming channel, it:
   - Records the state of that channel as everything received before the marker.
   - Stops recording messages from that channel afterward.

2. **If no other messages arrive on that channel before the marker**:  
   If a node receives a marker on an incoming channel and there were no messages received on that channel prior to the marker, it records the channel's state as **empty** and stops recording from that channel.

This ensures that:
- Each channel's state is captured as the set of messages received before the marker.
- Once the marker is received, recording for that specific channel ceases.

This mechanism helps maintain a **consistent global state** across all nodes in the distributed system.
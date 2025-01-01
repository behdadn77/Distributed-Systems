

**Question**: three peers (IDs0= 0, 7, 12) participate in a circular DHT with finger table using the CHORD protocol.
assume that the DHT uses 4-bits to represent the node IDs and keys. show the routing table of the three peers.

**Answer**:
First, recall the basics of a 4-bit Chord ring:

- The Chord ring has 16 possible IDs (0 through 15).  
- Each node \( n \) maintains up to \(\log_2(16) = 4\) finger entries.  
- The \(k\)-th finger of node \(n\) (where \(k\) runs from 1 to 4) points to the successor of  
  \[
    (n + 2^{k-1}) \mod 16.
  \]

We have three live nodes in the ring:  
\[
\{\,0,\,7,\,12\}.
\]

---

### 1. Finger Table for Node 0

We compute the 4 fingers as follows:

1. \(0 + 2^{0} = 1 \mod 16 = 1\)  
   - Successor of ID 1 is the first live node \(\geq 1\) on the ring, which is node 7.  
2. \(0 + 2^{1} = 2 \mod 16 = 2\)  
   - Successor of ID 2 is node 7.  
3. \(0 + 2^{2} = 4 \mod 16 = 4\)  
   - Successor of ID 4 is node 7.  
4. \(0 + 2^{3} = 8 \mod 16 = 8\)  
   - Successor of ID 8 is the first live node \(\geq 8\), which is node 12.  

Hence Node 0’s finger table is:

| Finger k | Start \((0 + 2^{k-1})\mod 16\) | Successor |
|----------|--------------------------------|-----------|
| k = 1    | 1                              | 7         |
| k = 2    | 2                              | 7         |
| k = 3    | 4                              | 7         |
| k = 4    | 8                              | 12        |

---

### 2. Finger Table for Node 7

We compute similarly for node 7:

1. \(7 + 2^{0} = 8 \mod 16 = 8\)  
   - Successor of ID 8 is node 12.  
2. \(7 + 2^{1} = 9 \mod 16 = 9\)  
   - Successor of ID 9 is node 12.  
3. \(7 + 2^{2} = 11 \mod 16 = 11\)  
   - Successor of ID 11 is node 12.  
4. \(7 + 2^{3} = 15 \mod 16 = 15\)  
   - Successor of ID 15 is the first live node \(\geq 15\). None is \(\geq 15\), so we wrap around to node 0.  

Hence Node 7’s finger table is:

| Finger k | Start \((7 + 2^{k-1})\mod 16\) | Successor |
|----------|--------------------------------|-----------|
| k = 1    | 8                              | 12        |
| k = 2    | 9                              | 12        |
| k = 3    | 11                             | 12        |
| k = 4    | 15                             | 0         |

---

### 3. Finger Table for Node 12

Finally, for node 12:

1. \(12 + 2^{0} = 13 \mod 16 = 13\)  
   - Successor of ID 13 is node 0 (the next live node after 12 is 0).  
2. \(12 + 2^{1} = 14 \mod 16 = 14\)  
   - Successor of ID 14 is node 0.  
3. \(12 + 2^{2} = 16 \mod 16 = 0\)  
   - Successor of ID 0 is node 0 itself.  
4. \(12 + 2^{3} = 20 \mod 16 = 4\)  
   - Successor of ID 4 is node 7 (the first node \(\geq 4\) is 7).  

Hence Node 12’s finger table is:

| Finger k | Start \((12 + 2^{k-1})\mod 16\) | Successor |
|----------|---------------------------------|-----------|
| k = 1    | 13                              | 0         |
| k = 2    | 14                              | 0         |
| k = 3    | 0                               | 0         |
| k = 4    | 4                               | 7         |

---

#### Summary of Finger Tables

**Node 0**  
- Finger[1] = 7  
- Finger[2] = 7  
- Finger[3] = 7  
- Finger[4] = 12  

**Node 7**  
- Finger[1] = 12  
- Finger[2] = 12  
- Finger[3] = 12  
- Finger[4] = 0  

**Node 12**  
- Finger[1] = 0  
- Finger[2] = 0  
- Finger[3] = 0  
- Finger[4] = 7  

These tables reflect how each node will forward lookups for IDs in a 4-bit Chord ring containing only the nodes 0, 7, and 12.

---

**Question**: peer 12 wants to retrieve the value of an object having key 15. show the exchange of messages required to search the desired value

**Answer**:
First, recall **who** is responsible for key 15 in this 3‑node Chord ring (with IDs 0, 7, 12 in a 4‑bit ID space). In standard Chord, a node \(n\) is responsible for all keys in the half-open interval \((\text{pred}(n),\,n]\) on the identifier circle.

- Node 0’s predecessor is 12.  
- Therefore, node 0 is responsible for keys in \((12,0]\) modulo 16.  
- The numeric interval \((12,0]\) in mod 16 is \(\{13,14,15,0\}\).  
- Hence **node 0** holds the object whose key is 15.

---

### How Peer 12 Routes a Lookup for Key = 15

Below is a simplified description of the Chord “lookup(key)” procedure:

1. **Check if key is in \((n, \text{successor}(n)]** (mod \(2^m\)).  
   - If yes, forward the request directly to \(\text{successor}(n)\).  
   - If no, forward the request to the “best finger” that precedes the key.

Given:
- Node 12’s successor is node 0.
- Key = 15 lies in \((12, 0]\) on the circular identifier space.

Therefore, node 12 immediately sees that 15 is in \((12,0]\) and forwards the request to its successor, node 0.

### Message Flow

1. **Node 12 → Node 0**: “Lookup(key=15)”  
   - Node 12 sends a lookup request to node 0, because 0 is the successor of 12 and covers keys 13, 14, 15, and 0.

2. **Node 0 checks responsibility**  
   - Node 0 sees it is responsible for key=15 (since 15 is in \((12,0]\)).

3. **Node 0 → Node 12**: returns the value  
   - Node 0 replies back to node 12 with the stored value for key=15.

Hence, only **two messages** are needed:
1. A “find the key” (lookup) request from node 12 to node 0  
2. A “here is your value” reply from node 0 back to node 12


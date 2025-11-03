class MinHeap {
  constructor(cmp = (a, b) => a.d - b.d){
    this.a = []
    this.cmp = cmp
  }

  size(){
    return this.a.length
  }

  push(x){
    this.a.push(x)
    this._siftUp(this.a.length - 1)
  }

  pop(){
    if(this.a.length === 0)
      return null
    const top = this.a[0]
    const last = this.a.pop()
    if(this.a.length){
      this.a[0] = last
      this._siftDown(0)
    }
    return top
  }

  _siftUp(i){
    while(i > 0){
      const parent = (i - 1) >> 1
      if(this.cmp(this.a[i], this.a[parent]) >= 0)
        break
      [this.a[i], this.a[parent]] = [this.a[parent], this.a[i]]
      i = parent
    }
  }

  _siftDown(i){
    const n = this.a.length
    while(true){
      let l = i * 2 + 1
      let r = l + 1
      let m = i
      if(l < n && this.cmp(this.a[l], this.a[m]) < 0)
        m = l
      if(r < n && this.cmp(this.a[r], this.a[m]) < 0)
        m = r
      if(m === i)
        break
      [this.a[i], this.a[m]] = [this.a[m], this.a[i]]
      i = m
    }
  }
}

let input = ''

process.stdin.on('data', (chunk) => {
  input += chunk
})

process.stdin.on('end', () => {
  const lines = input.trim().split('\n')
  //ignore 4th element
  const [N, M, K] = lines[0].split(/\s+/).map(Number)
  const cypria = lines[1].split(/\s+/).map(Number)
  const [S, T] = lines[2].split(/\s+/).map(Number)

  const roads = lines.slice(3).map(l => l.split(/\s+/).map(Number))

  const cities = Array.from({length:N+1}, () => {
    const obj = {
      links: [],
      cypria: false,
    }
    return obj
  })
  cities[0] = null

  cypria.forEach(i => cities[i].cypria = true)

  roads.forEach( ([u, v, w, p]) => {
    cities[u].links.push({
      from: u,
      to: v,
      weight: w,
      safe: p
    })
    cities[v].links.push({
      from: v,
      to: u,
      weight: w,
      safe: p
    })
  })

  // dist[node][k][cy] = best distance to reach node with k sneaky roads used
  // and cy=0/1 indicating whether we've touched a Cyprian city along the way.
  const dist = Array.from({ length: N + 1 }, () =>
    Array.from({ length: K + 1 }, () => [Infinity, Infinity])
  )

  const startCy = cities[S].cypria ? 1 : 0
  dist[S][0][startCy] = 0

  // Simple binary-heap priority queue
  const pq = new MinHeap((x, y) => x.d - y.d)
  pq.push({
    node: S,
    k: 0,
    cy: startCy,
    d: 0
  })

  while(pq.size()){
    const { node, k, cy, d } = pq.pop()

    // Skip stale entries
    if(d !== dist[node][k][cy])
      continue

    // If we've reached T with the cyprian condition satisfied,
    // this is optimal by Dijkstra’s property—return immediately.
    if(node === T && cy === 1){
      console.log(d)
      return
    }

    for(const road of cities[node].links){
      const next_k = k + road.safe
      if(next_k > K)
        continue

      const next_cy = (cy === 1 || cities[road.to].cypria) ? 1 : 0
      const next_d = d + road.weight

      if(next_d < dist[road.to][next_k][next_cy]){
        dist[road.to][next_k][next_cy] = next_d
        pq.push({ node: road.to, k: next_k, cy: next_cy, d: next_d })
      }
    }
  }

  // If we didn’t early-return, there's no valid path
  console.log(-1)
})


import React from 'react';
import BenchesIndex from '../benches/benches_index'
import BenchMap from '../benches/bench_map'

export default ({ benches, fetchBenches }) => (
  <div>
    <BenchMap benches={benches} />
    <h1>Hello?</h1>
    <BenchesIndex fetchBenches={fetchBenches} benches={benches}/>
  </div>
)

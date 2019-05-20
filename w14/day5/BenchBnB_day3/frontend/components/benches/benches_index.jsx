import React from 'react'
import BenchIndexItem from './bench_index_item'

class BenchesIndex extends React.Component {
  constructor (props) {
    super(props)
    this.state = { benches: [] }
  }

  componentDidMount () {
    this.props.fetchBenches()
    // debugger
    // this.setState({ benches: this.props.fetchBenches() })
  }

  render () {
    const benches = this.props.benches.map(bench => {
      return <BenchIndexItem key={bench.id} bench={bench}/>
    })

    return (
      <div>
        <ul>
          {benches}
        </ul>
      </div>
    )
  }
}

export default BenchesIndex

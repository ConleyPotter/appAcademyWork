export const fetchBenches = (filters) => (
  $.ajax({
    method: 'GET',
    url: 'api/benches',
    error: (error) => { console.log(error) }
  })
)

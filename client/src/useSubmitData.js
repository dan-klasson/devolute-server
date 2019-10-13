import { useState, useCallback } from 'react'

export default function useSubmitData({endpoint}) {
  const [res, setRes] = useState({data: null, error: null, loading: false});
  const submitData = useCallback((payload) => {
    setRes(prevState => ({...prevState, loading: true}))
    window
      .fetch(`http://${process.env.REACT_APP_API_DOMAIN}/${endpoint}`, {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(payload)
      })
      .then(r => r.json())
      .then((response) => {
        console.log(response)
        if(response.success) {
          setRes({data: response.result, loading: false, error: null})
        } else {
          setRes({loading: false, data: null, error: response.errors})
        }
      })
  }, [endpoint])
  return [res, submitData]
}
import React, { useReducer } from 'react'
import  { Redirect } from 'react-router-dom'
import { useCookies } from 'react-cookie';
import Form from 'react-bootstrap/Form'
import Button from 'react-bootstrap/Button'
import Alert from 'react-bootstrap/Alert'
import { Formik } from 'formik'
import { string, object } from 'yup'

const schema = object({
  email: string()
    .email('E-mail is not valid!')
    .required('E-mail is required!'),
  password: string()
    .min(6, 'Password has to be longer than 6 characters!')
    .required('Password is required!'),
})

export default function Login() {
  const [cookies, setCookie] = useCookies(['authtoken']);
  const [state, setState] = useReducer((s, a) => ({...s, ...a}), {
    resolved: false,
    loading: false,
    error: null,
  })
  const handleLogin = (data) => {
    setState({loading: true, resolved: false, error: null})
    window
      .fetch(`http://${process.env.REACT_APP_API_DOMAIN}/authentication`, {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(data)
      })
      .then(r => r.json())
      .then((response) => {
        if(response.success) {
          setState({loading: false, resolved: true, error: null})
          setCookie('authtoken', response.result)
        } else {
          setState({loading: false, resolved: false, error: response.errors})
        }
      })
  }

  if(state.resolved || cookies.authtoken) {
    return <Redirect to="/" />
  }

  return (
    <Formik
      validationSchema={schema}
      onSubmit={handleLogin}
    >
      {({
        handleSubmit,
        handleChange,
        touched,
        errors,
      }) => (
        <Form onSubmit={handleSubmit} className="form" data-testid="form">
          <Form.Group controlId="email">
            <Form.Label>Email</Form.Label>
            <Form.Control
              type="email"
              name="email"
              placeholder="Enter email"
              onChange={handleChange}
              isInvalid={!!errors.email}
              isValid={touched.email && !errors.email}
            />
            <Form.Control.Feedback type="invalid" data-testid="invalid-email">
              {errors.email}
            </Form.Control.Feedback>
          </Form.Group>
          <Form.Group controlId="password">
            <Form.Label>Password</Form.Label>
            <Form.Control
              name="password"
              type="password"
              placeholder="Password"
              isInvalid={!!errors.password}
              onChange={handleChange}
              isValid={touched.email && !errors.email}
            />
            <Form.Control.Feedback type="invalid" data-testid="invalid-password">
              {errors.password}
            </Form.Control.Feedback>
          </Form.Group>
          {state.error ? (
            <Alert variant="danger" data-testid="invalid-login">
              {state.error.user_authentication}
            </Alert>) : null}
          <Button variant="primary" type="submit">
            Submit
          </Button>
        </Form>
        )}
    </Formik>
  )
}
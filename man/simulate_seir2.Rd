% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/1-doherty-model.R
\name{simulate_seir2}
\alias{simulate_seir2}
\title{Simulate a deterministic SEIR model with quarantine and hospitalisation ("Doherty" or "Moss") model}
\usage{
simulate_seir2(t, state_t0, param)
}
\arguments{
\item{t}{Number of time steps over which to sample from the model}

\item{state_t0}{Initial state of the model (see seir2_state0)}

\item{param}{Model parameters (see seir2_param)}
}
\value{
Object of class covoid
}
\description{
\Sexpr[results=rd, stage=render]{lifecycle::badge("experimental")}

\itemize{
\item S = Susceptible
\item E1/Eq1 = Exposed (asymptomatic; not infectious)
\item E2/Eq2 = Exposed (asymptomatic; infectious)
\item I1/Iq1 = First infectious period
\item I2/Iq2 = Second infection period
\item M/Mq = Under medical management (hospitalised; GP)
\item R/Rq/Rm/Rqm = Recovered
}

Partial implementation of the model outlined in Moss et al (2020).
}
\examples{
param <- seir2_param(R0=2.53,lambdaimp=0,sigma1=1/1.6,sigma2=1/1.6,gamma1=1/4.0,gamma2=1/5.68,gammaq1=1/4.0,gammaq2=1/5.68,Qeff=0.5,Meff=0,rho=0,eta=1/sqrt(2),alphamBeta=0.5,probHospGivenInf=0.09895,delta=1/14,kappa=20,pm=1)
state0 <- seir2_state0(S=100,E1=1)
res <- simulate_seir2(t = 100,state_t0 = state0,param = param)

# with self-quarantine
param <- seir2_param(R0=2.5,lambdaimp=0,sigma1=0.3,sigma2=0.3,gamma1=0.3,gamma2=0.3,gammaq1=0.3,gammaq2=0.3,Qeff=0.5,Meff=0.99,rho=0.8,eta=1/sqrt(2),alphamBeta=0.5,probHospGivenInf=0.09895,delta=1/14,kappa=20,pm=1)
state0 <- seir2_state0(S=100,E1=1)
res <- simulate_seir2(t = 100,state_t0 = state0,param = param)

}

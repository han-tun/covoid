% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/1-seir-cm-model.R
\name{simulate_seir_c}
\alias{simulate_seir_c}
\title{Simulate a deterministic age structured SEIR model}
\usage{
simulate_seir_c(t, state_t0, param)
}
\arguments{
\item{t}{Number of time steps over which to sample from the model}

\item{state_t0}{Initial state of the model (see ?seir_state0)}

\item{param}{Model parameters (see ?seir_param)}
}
\value{
Object of class covoidd and dcm (from the package EpiModels)
}
\description{
\Sexpr[results=rd, stage=render]{lifecycle::badge("maturing")}

S = Susceptible
E = Exposed (latent period)
I = Infectious
R = Removed (recovered or died)
}
\examples{
# Example 1: no interventions
cm_oz <- import_contact_matrix("Australia","general")
nJ <- ncol(cm_oz)
dist_oz <- import_age_distribution("Australia")
S <- rep(1000,nJ)
E <- rep(1,nJ)
I <- rep(0,nJ)
R <- rep(0,nJ)
state0 <- seir_c_state0(S = S,E = E,I = I,R = R)
param1 <- seir_c_param(R0 = 2.5,sigma=0.1,gamma = 0.1,cm=cm_oz,dist=dist_oz)
res1 <- simulate_seir_c(t = 150,state_t0 = state0,param = param1)
plot(res1,y=c("S","E","I","R"))

# Example 2: general physical distancing, school closures and masks/handwashing
cm_oz_all <- import_contact_matrix("Australia","general")
cm_oz_sch <- import_contact_matrix("Australia","school")
cm <- list(all = cm_oz_all, sch = cm_oz_sch)
# separate out school and general population contact rates
cm_oz_all <- cm_oz_all - cm_oz_sch
int <- list(sch=contact_intervention(start = 10,stop = 150,reduce = 0.2,start_delay = 5,stop_delay = 5),
          all=contact_intervention(start = 10,stop = 150,reduce = 0.8,start_delay = 5,stop_delay = 5))
int_t <- transmission_intervention(start = 10,stop = 200,reduce = 0.9,start_delay = 5,stop_delay = 5)
param2 <- seir_c_param(R0 = 2.5,sigma=0.1,gamma = 0.1,
                     cm=list(sch=cm_oz_sch,
                             all=cm_oz_all),
                     dist=dist_oz,
                     contact_intervention=int,
                     transmission_intervention=int_t)
res2 <- simulate_seir_c(t = 150,state_t0 = state0,param = param2)
plot(res2,y=c("S","E","I","R"))

# Example 3: as #2 with children (<15) less infectious/susceptible
im <- matrix(1,ncol=16,nrow=16)
im[,1:3] <- 0.8
param3 <- seir_c_param(R0 = 2.5,sigma=0.1,gamma = 0.1,
                     cm=list(sch=cm_oz_sch,
                             all=cm_oz_all),
                     dist=dist_oz,
                     contact_intervention=int,
                     transmission_intervention=int_t,
                     im=im)
res3 <- simulate_seir_c(t = 200,state_t0 = state0,param = param3)
plot(res3,y=c("S","E","I","R"))

}

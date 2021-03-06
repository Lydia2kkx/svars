context("test-id_cv.R")

test_that("unrestricted id.cv estimation with 3-dim works", {
  skip_on_cran()
  set.seed(23211)
  v1 <- vars::VAR(USA, p = 6, ic = "AIC" )
  x1 <- id.cv(v1, SB = 59)
  x2 <- id.cv_boot(v1, SB = 59)

  expect_equal(round(x1$Lik, 4), round(x2$Lik, 4), -98.3976)
  expect_equal(round(sum(diag(x1$Lambda)),4), round(sum(diag(x2$Lambda)),4), 1.8272)
  expect_equal(round(sum(x1$B),4), round(sum(x2$B),4), 3.2471)

  expect_equal(round(sum(x1$Lambda_SE), 4), 0.4312)

  expect_equal(x1$K, x2$K, 3)
  expect_equal(x1$n, x2$n, 169)
  expect_equal(x1$restrictions,x2$restrictions, 0)
  expect_equal(x1$SB,x2$SB, 59)
  expect_equal(x1$p,x2$p, 6)
  expect_equal(x1$iteration,x2$iteration, 6)

  expect_match(x1$method, x2$method, "Changes in Volatility")
})

test_that("unrestricted id.cv and boot estimation with 2-dim works", {
  skip_on_cran()
  set.seed(23211)
  v1 <- vars::VAR(USA[,-3], p = 3, ic = "AIC" )
  x1 <- id.cv(v1, SB = 59)
  x2 <- id.cv_boot(v1, SB = 59)
  expect_equal(round(x1$Lik, 4),round(x2$Lik, 4), -105.4419)
  expect_equal(round(sum(diag(x1$Lambda)),4),round(sum(diag(x2$Lambda)),4), 0.7017)
  expect_equal(round(sum(x1$B),4),round(sum(x2$B),4), 2.4101)

  expect_equal(round(sum(x1$Lambda_SE), 4), 0.1625)

  expect_equal(x1$K,x2$K, 2)
  expect_equal(x1$n,x2$n, 172)
  expect_equal(x1$restrictions,x2$restrictions, 0)
  expect_equal(x1$SB,x2$SB, 59)
  expect_equal(x1$p,x2$p, 3)
  expect_equal(x1$iteration,x2$iteration, 4)

  expect_match(x1$method, x2$method, "Changes in Volatility")
})

test_that("restricted id.cv and boot estimation with 3-dim works", {
  skip_on_cran()
  set.seed(23211)
  v1 <- vars::VAR(USA, p = 6, ic = "AIC" )
  restmat <- matrix(NA,3,3)
  restmat[1,c(2,3)] <- 0
  restmat[2,3] <- 0
  x1 <- id.cv(v1, SB = 59, restriction_matrix = restmat)
  x2 <- id.cv_boot(v1, SB = 59, restriction_matrix = restmat)
  expect_equal(round(x1$Lik, 4), round(x2$Lik, 4), -102.7646)
  expect_equal(round(sum(diag(x1$Lambda)),4), round(sum(diag(x2$Lambda)),4), 1.5285)
  expect_equal(round(sum(x1$B),4),round(sum(x2$B),4), 3.8043)

  expect_equal(round(sum(x1$Lambda_SE), 4), 0.3664)

  expect_equal(x1$K, x2$K, 3)
  expect_equal(x1$n,x2$n, 169)
  expect_equal(x1$restrictions,x2$restrictions, 3)
  expect_equal(x1$SB,x2$SB, 59)
  expect_equal(x1$p,x2$p, 6)
  expect_equal(x1$iteration,x2$iteration, 5)

  expect_match(x1$method, x2$method, "Changes in Volatility")
})

test_that("restricted id.cv and boot estimation with 2-dim works", {
  skip_on_cran()
  set.seed(23211)
  v1 <- vars::VAR(USA[,-3], p = 3, ic = "AIC" )
  restmat <- matrix(NA,2,2)
  restmat[1,2] <- 0
  x1 <- id.cv(v1, SB = 59, restriction_matrix = restmat)
  x2 <- id.cv_boot(v1, SB = 59, restriction_matrix = restmat)

  expect_equal(round(x1$Lik, 4), round(x2$Lik, 4), -106.2008)
  expect_equal(round(sum(diag(x1$Lambda)),4), round(sum(diag(x2$Lambda)),4), 0.6749)
  expect_equal(round(sum(x1$B),4), round(sum(x2$B),4), 2.5518)

  expect_equal(round(sum(x1$Lambda_SE), 4), 0.1566)

  expect_equal(x1$K, x2$K, 2)
  expect_equal(x1$n,x2$n, 172)
  expect_equal(x1$restrictions,x2$restrictions, 1)
  expect_equal(x1$SB, x2$SB, 59)
  expect_equal(x1$p,x2$p, 3)
  expect_equal(x1$iteration, x2$iteration, 4)

  expect_match(x1$method, x2$method, "Changes in Volatility")
})

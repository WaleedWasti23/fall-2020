#Problem Set 3


using Optim, HTTP, GLM, LinearAlgebra, Random, Statistics, DataFrames, CSV, FreqTables
url="https://raw.githubusercontent.com/OU-PhD-Econometrics/fall-2020/master/ProblemSets/PS3-gev/nlsw88w.csv"

function q4()
#::::::::::::::::::::::::::::::::::::::::::::::
# Question 1
#::::::::::::::::::::::::::::::::::::::::::::::

df = CSV.read(HTTP.get(url).body)
X = [df.age df.white df.collgrad]
Z = hcat(df.elnwage1, df.elnwage2, df.elnwage3, df.elnwage4, df.elnwage5, df.elnwage6, df.elnwage7, df.elnwage8)
y = df.occupation

function mlogit(beta, X, Z, y)

    K = size(X,2)+1
    J = length(unique(y))
    N = length(y)
    bigY = zeros(N,J)
    for j=1:J
        bigY[:,j] = y.==j
    end
    bigBeta = [reshape(Beta,K,J-1) zeros(K)]

    num = zeros(N,J)
    dem = zeros(N)
    for j=1:J
        num[:,j] = exp.(X*bigBeta[:,j])
        dem .+= num[:,j]
    end

    bigZ = zeros(N,J)
       for j=1:J
           bigZ[:,j] = Z[:,j]-Z[:,J]
       end

    P = num./repeat(dem,1,J)

    loglike = -sum( bigY.*log.(P) )

    return loglike
end


println(loglikelihood)



q4()

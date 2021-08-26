pipeline 
{ 
    agaent
    {    
        label 'worker2'
    }
        stages
        {
            stage("Build app1 docker file")
            {
                steps
                {
                    sh '''
                    docker build -t app1 -f app1.dockerfile .
                    '''
                }
            }
            stage("Build app2 docker file")
            {
                steps
                {
                    sh '''
                    docker build -t app2 -f app2.dockerfile .
                    '''
                }
            }
            stage("Build lb docker file")
            {
                steps
                {
                    sh '''
                    docker build -t lb -f lb.dockerfile .
                    '''
                }
            }
            stage("run app1 docker image")
            {
                steps
                {
                    sh '''
                    docker rm -f app1 | exit 0
                    docker run -d -p 5001:80 --name app1 app1
                    '''
                }
            }
            stage("run app1 docker image")
            {
                steps
                {
                    sh '''
                    docker rm -f app1 | exit 0
                    docker run -d -p 5001:80 --name app1 app1
                    '''
                }
            }
            stage("run app2 docker image")
            {
                steps
                {
                    sh '''
                    docker rm -f app2 | exit 0
                    docker run -d -p 5002:80 --name app2 app2                    
                    '''
                }
            }
            stage("run loadbalancer docker image")
            {
                steps
                {
                    sh '''
                    docker rm -f lb | exit 0
                    docker run -d -p 80:80 --name lb lb 
                                   
                    '''
                }
            }



        } 
    
}

pipeline 
{ 
    agent
    {    
        label 'piserver'
    }
        stages
        {
            stage("k8-deploy")
            {
                steps
                {
                    sh '''
                    cd k8master
                    kubectl delete -f nginx-deploy.yml | exit 0
                    kubectl apply -f nginx-deploy.yml
                    '''
                }
            }



        } 
    
}

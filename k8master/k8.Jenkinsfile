pipeline 
{ 
    agaent
    {    
        label 'lp-k8master-1'
    }
        stages
        {
            stage("k8-deploy")
            {
                steps
                {
                    sh '''
                    kubectl delete -f nginx-deploy.yml | exit 0
                    kubectl apply -f nginx-deploy.yml
                    '''
                }
            }



        } 
    
}

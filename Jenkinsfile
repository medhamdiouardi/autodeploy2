
node {
   def registryProjet='registry.gitlab.com/sfm5/autodeploy2'
   def IMAGE="${registryProjet}:version-${env.BUILD_ID}"
    stage('Clone') {
          git branch: 'main', credentialsId: 'cred', url: 'https://gitlab.com/sfm5/autodeploy2.git'
    }
    stage('Maven package'){
            sh 'mvn package'
    }
    def img = stage('Build') {
          docker.build("$IMAGE",  '.')
    }
    stage('Run') {
            img.withRun("--name run-$BUILD_ID -p 8081:8080") { c ->
            sh 'docker ps'
            sh 'netstat -ntaup'
            sh 'sleep 30s'
            sh 'curl 192.168.15.128:8081'
            sh 'docker ps'
          }
    }
    stage('Push to container Gitlab ') {
          docker.withRegistry('https://registry.gitlab.com', 'cred') {
              img.push 'latest'
              img.push()
          }
    }
    stage('Push to tomcat ') {
        deploy adapters: [tomcat9(credentialsId: 'tomcat', path: '', url: 'http://192.168.15.128:8090/')], contextPath: 'SFM', war: 'target/hello-world-war-1.0.0.war'}
 
 stage('mail notification'){
     mail bcc: '', body: 'noreply automated mail to inform about the uploading of the app in the server  ', cc: '', from: '', replyTo: '', subject: 'app deployed ', to: 'medhamdiouardi@gmail.com'
     
 }
  }

 
 
 
 

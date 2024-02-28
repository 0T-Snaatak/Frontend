@Library("my-shared-library") _
// testing  webhook-001

// testing  salary CI webhook-001
def frotendCI = new org.avengers.template.frontendCI.frontendCI()

node {
    
    def url = 'https://github.com/CodeOps-Hub/Frontend.git'
    def branch = 'feature/frontendCI'
    def gitLeaksVersion = '8.18.2'
    def reportName = 'credScanReport.json'
    
    frotendCI.call(branch: branch,url: url, gitLeaksVersion, reportName)
    
}

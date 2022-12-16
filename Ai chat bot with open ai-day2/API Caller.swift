import OpenAISwift
import Foundation

final class APICaller:ObservableObject{
    
    private var client:OpenAISwift?
    
     init(){}
    
    public func setup(){
         client = OpenAISwift(authToken: "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")
    }
    
    public func send(textInput:String,//its used to get a response ... inshort get method
                            completion:@escaping(String)->Void){
        client?.sendCompletion(with: textInput,maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(output)
            case .failure(let error):
                print("get method failed")
                break
            }
        })
    }
}

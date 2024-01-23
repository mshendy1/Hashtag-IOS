//
//  RegisterViewModel.swift
//  HashTag
//
//  Created by Mohamed Shendy on 07/02/2023.
//

import Foundation

protocol SelectCategoryViewModelDelegate: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func getCategorySuccessfully(categories:[CategoryModel]?)
    func getTagsSuccessfully(tags:[TagsModel]?)
    func addCategorySuccessfully()
    func addTagsSuccessfully()
}

class SelectCategoryViewModel {
    weak var delegate: SelectCategoryViewModelDelegate?
    init(delegate:SelectCategoryViewModelDelegate?) {
        self.delegate = delegate
    }
    
    var categoriesArray: [CategoryModel]?
    var tagsArray: [TagsModel]?

    func callGetCategoryApi(){
        self.delegate?.showLoading()
        AuthNetworkManger.getCategoryApi() { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.categoriesArray = model?.data
                self.delegate?.getCategorySuccessfully(categories:model?.data )
            }else if (error != nil)
            {
                self.delegate?.showError(error: error!.localizedDescription)
            }
        }
    }
   
    func callGetTagsApi(){
        self.delegate?.showLoading()
        AuthNetworkManger.getTagsApi() { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.tagsArray = model?.data
                self.delegate?.getTagsSuccessfully(tags: self.tagsArray ?? [])
            }else if (error != nil)
            {
                self.delegate?.showError(error: error!.localizedDescription)
            }
        }
    }
    
    
    func callAddCategoryApi(categoryId:[Int]) {
        self.delegate?.showLoading()
        AuthNetworkManger.addCategoryApi(categoryId: categoryId) { (model, error) in
            
            self.delegate?.killLoading()
            
            if (model != nil) {
                self.delegate?.addCategorySuccessfully()
                
            }else if (error != nil)
            {
                self.delegate?.showError(error: error!.localizedDescription)
            }
        }
    }
    
    
}

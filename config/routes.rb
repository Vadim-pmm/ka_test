Rails.application.routes.draw do

  devise_for :users, controllers: {registrations: 'user/registrations', sessions: 'user/sessions'}
  root to: 'vacancies#index'

  resources :vacancies do
    collection do
      post 'append_skill'
      post 'remove_skill/:id', to: 'vacancies#remove_skill', as: 'remove'
      get  'search/:id', to: 'vacancies#search_for_candidates', as: 'search'
    end
  end

  resources :skills, only: [:new, :create, :destroy] do
    get 'accept', on: :member
  end
  resources :candidates, only: [:index, :show, :edit, :update] do
    collection do
      post 'append_skill'
      post 'remove_skill/:id', to: 'candidates#remove_skill', as: 'remove'
      get  'search', to: 'candidates#search_for_vacancies'
    end
  end
end

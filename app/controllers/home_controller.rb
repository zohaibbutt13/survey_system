require 'will_paginate/array'

class HomeController < ApplicationController
  # get home/index
  def index
    @surveys = [ {name: 'survey1', description: " Survery 1 description here"},
                 {name: 'survey2', description: " Survery 2 description here"},
                 {name: 'survey3', description: " Survery 3 description here"},
                 {name: 'survey4', description: " Survery 4 description here"},
                 {name: 'survey5', description: " Survery 5 description here"},
                 {name: 'survey6', description: " Survery 6 description here"},
                 {name: 'survey7', description: " Survery 7 description here"},
                 {name: 'survey8', description: " Survery 8 description here"},
               ].paginate(page: params[:page], per_page: 6)
  end

  # get home/packages
  def packages
    @packages = [ {package_name: 'Platinum', max_supervisors: 50, max_members: 500},
                  {package_name: 'Gold', max_supervisors: 20, max_members: 200},
                  {package_name: 'Silver', max_supervisors: 10, max_members: 100},
                ]
  end
end

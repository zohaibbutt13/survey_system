require 'will_paginate/array'

# get home/index
class HomeController < ApplicationController
  def index
    # UPDATE: dummy @surveys array below will be replaced by surveys object
    # @surveys = ['survey1', 'survey2', 'survey3',
    #             'survey4', 'survey5', 'survey6',
    #             'survey7', 'survey8'].paginate(page: params[:page], per_page: 6)
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

  def packages
    # UPDATE: dummy @packages array will be replaced by packages object
    @packages = [ {package_name: 'Platinum', max_supervisors: 50, max_members: 500},
                  {package_name: 'Gold', max_supervisors: 20, max_members: 200},
                  {package_name: 'Silver', max_supervisors: 10, max_members: 100},
                ]
  end
end

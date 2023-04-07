# frozen_string_literal: true

require "clever_api/api"
require "clever_api/error"
require "clever_api/data/courses"
require "clever_api/data/districts"
require "clever_api/data/resources"
require "clever_api/data/schools"
require "clever_api/data/sections"
require "clever_api/data/terms"
require "clever_api/data/users"

module CleverApi
  class Client
    attr_accessor :access_token, :configuration

    def initialize(access_token, configuration = CleverApi.configuration)
      @access_token = access_token
      @configuration = configuration
    end

    # count - acceptable values are nil, :true, :false, :undefined
    def courses(limit: nil, starting_after: nil, ending_before: nil, count: nil)
      response = api.courses(access_token: access_token,
        limit: limit, starting_after: starting_after, ending_before: ending_before, count: count)
      CleverApi::Data::Courses.new(response)
    end

    def course(id)
      response = api.course(access_token: access_token, id: id)
      data = response.body.dig("data")
      CleverApi::Data::Course.new(data, response)
    end

    def course_schools(id, limit: nil, starting_after: nil, ending_before: nil)
      response = api.course_schools(access_token: access_token, id: id,
        limit: limit, starting_after: starting_after, ending_before: ending_before)
      CleverApi::Data::Schools.new(response)
    end

    def districts(count: nil)
      response = api.districts(access_token: access_token, count: count)
      CleverApi::Data::Districts.new(response)
    end

    def district(id)
      response = api.district(access_token: access_token, id: id)
      data = response.body.dig("data")
      CleverApi::Data::District.new(data, response)
    end

    def resources(limit: nil, starting_after: nil, ending_before: nil)
      response = api.resources(access_token: access_token,
        limit: limit, starting_after: starting_after, ending_before: ending_before)
      CleverApi::Data::Resources.new(response)
    end

    def resource(id)
      response = api.resource(access_token: access_token, id: id)
      data = response.body.dig("data")
      CleverApi::Data::Resources.new(data, response)
    end

    # count - acceptable values are nil, :true, :false, :undefined
    def schools(limit: nil, starting_after: nil, ending_before: nil, count: nil)
      response = api.schools(access_token: access_token,
        limit: limit, starting_after: starting_after, ending_before: ending_before, count: count)
      CleverApi::Data::Schools.new(response)
    end

    def school(id)
      response = api.school(access_token: access_token, id: id)
      data = response.body.dig("data")
      CleverApi::Data::School.new(data, response)
    end

    def school_courses(id, limit: nil, starting_after: nil, ending_before: nil)
      response = api.school_courses(access_token: access_token, id: id,
        limit: limit, starting_after: starting_after, ending_before: ending_before)
      CleverApi::Data::Courses.new(response)
    end

    def school_district(id)
      response = api.school_district(access_token: access_token, id: id)
      data = response.body.dig("data")
      CleverApi::Data::District.new(data, response)
    end

    # role - acceptable values are nil, :staff, :student, :teacher
    # primary - acceptable values are nil, true
    def school_users(id, role: nil, primary: nil, limit: nil, starting_after: nil, ending_before: nil)
      response = api.school_users(access_token: access_token, id: id, role: role, primary: primary,
        limit: limit, starting_after: starting_after, ending_before: ending_before)
      CleverApi::Data::Users.new(response)
    end

    # count - acceptable values are nil, :true, :false, :undefined
    def sections(limit: nil, starting_after: nil, ending_before: nil, count: nil)
      response = api.sections(access_token: access_token,
        limit: limit, starting_after: starting_after, ending_before: ending_before, count: count)
      CleverApi::Data::Sections.new(response)
    end

    def section(id)
      response = api.section(access_token: access_token, id: id)
      data = response.body.dig("data")
      CleverApi::Data::Section.new(data, response)
    end

    def section_resources(id, limit: nil, starting_after: nil, ending_before: nil)
      response = api.section_resources(access_token: access_token, id: id,
        limit: limit, starting_after: starting_after, ending_before: ending_before)
      CleverApi::Data::Resources.new(response)
    end

    # count - acceptable values are nil, :true, :false, :undefined
    def terms(limit: nil, starting_after: nil, ending_before: nil, count: nil)
      response = api.terms(access_token: access_token,
        limit: limit, starting_after: starting_after, ending_before: ending_before, count: count)
      CleverApi::Data::Terms.new(response)
    end

    def term(id)
      response = api.term(access_token: access_token, id: id)
      data = response.body.dig("data")
      CleverApi::Data::Term.new(data, response)
    end

    # role - acceptable values are nil, :contact, :district_admin, :staff, :student, :teacher
    # count - acceptable values are nil, :true, :false, :undefined
    def users(role: nil, limit: nil, starting_after: nil, ending_before: nil, count: nil)
      response = api.users(access_token: access_token, role: role,
        limit: limit, starting_after: starting_after, ending_before: ending_before, count: count)
      CleverApi::Data::Users.new(response)
    end

    def user(id)
      response = api.user(access_token: access_token, id: id)
      data = response.body.dig("data")
      CleverApi::Data::User.new(data, response)
    end

    def user_resources(id, limit: nil, starting_after: nil, ending_before: nil)
      response = api.user_resources(access_token: access_token, id: id,
        limit: limit, starting_after: starting_after, ending_before: ending_before)
      CleverApi::Data::Resources.new(response)
    end

    def inspect
      "#<#{self.class.name}:0x#{(object_id * 2).to_s(16).rjust(16, "0")} #{access_token}>"
    end

    private

    def api
      @api ||= CleverApi::Api.new
    end
  end
end

# frozen_string_literal: true

require "base64"
require "json"
require "clever_api/api/response"

module CleverApi
  ##
  # private
  # CleverApi::Api is only responsible for making requests to Clever API.
  # CleverApi::Api is not responsible for managing authentication state.
  # CleverApi::Api is not responsible for specifying/using configured values.
  # CleverApi::Api is not responsible for iterating across multiple Clever API requests.
  class Api
    # district - the district's token
    def tokens(client_id:, client_secret:, district: nil)
      get(
        "https://clever.com/oauth/tokens",
        params: params(owner_type: :district, district: district),
        headers: basic_auth_headers(client_id, client_secret)
      )
    end

    def tokens!(client_id:, client_secret:, code: nil, grant_type: nil, redirect_uri: nil)
      post(
        "https://clever.com/oauth/tokens",
        body: JSON.dump(params(code: code, grant_type: grant_type, redirect_uri: redirect_uri)),
        headers: basic_auth_headers(client_id, client_secret).merge({"Content-Type" => "application/json"})
      )
    end

    def tokeninfo(access_token:)
      get(
        "https://clever.com/oauth/tokeninfo",
        headers: bearer_headers(access_token)
      )
    end

    def me(access_token:)
      get(
        "https://api.clever.com/v3.0/me",
        headers: bearer_headers(access_token)
      )
    end

    # count - acceptable values are nil, :true, :false, :undefined
    def courses(access_token:, limit: nil, starting_after: nil, ending_before: nil, count: nil)
      get(
        "https://api.clever.com/v3.0/courses",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before, count: count),
        headers: bearer_headers(access_token)
      )
    end

    def course(access_token:, id:)
      get(
        "https://api.clever.com/v3.0/courses/#{id}",
        headers: bearer_headers(access_token)
      )
    end

    def course_district(access_token:, id:)
      get(
        "https://api.clever.com/v3.0/courses/#{id}/district",
        headers: bearer_headers(access_token)
      )
    end

    def course_resources(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/courses/#{id}/resources",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end

    def course_schools(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/courses/#{id}/schools",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end

    def course_sections(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/courses/#{id}/sections",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end

    # count - acceptable values are nil, :true, :false, :undefined
    def districts(access_token:, count: nil)
      get(
        "https://api.clever.com/v3.0/districts",
        params: params(count: count),
        headers: bearer_headers(access_token)
      )
    end

    def district(access_token:, id:)
      get(
        "https://api.clever.com/v3.0/districts/#{id}",
        headers: bearer_headers(access_token)
      )
    end

    def resources(access_token:, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/resources",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end

    def resource(access_token:, id:)
      get(
        "https://api.clever.com/v3.0/resources/#{id}",
        headers: bearer_headers(access_token)
      )
    end

    def resource_courses(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/resources/#{id}/courses",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end

    def resource_sections(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/resources/#{id}/sections",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end

    # role - acceptable values are nil, :student, :teacher
    def resource_users(access_token:, id:, role: nil, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/resources/#{id}/users",
        params: params(role: role, limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end
    # def resource_students(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
    # def resource_teachers(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)

    # count - acceptable values are nil, :true, :false, :undefined
    def schools(access_token:, limit: nil, starting_after: nil, ending_before: nil, count: nil)
      get(
        "https://api.clever.com/v3.0/schools",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before, count: count),
        headers: bearer_headers(access_token)
      )
    end

    def school(access_token:, id:)
      get(
        "https://api.clever.com/v3.0/schools/#{id}",
        headers: bearer_headers(access_token)
      )
    end

    def school_courses(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/schools/#{id}/courses",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end

    def school_district(access_token:, id:)
      get(
        "https://api.clever.com/v3.0/schools/#{id}/district",
        headers: bearer_headers(access_token)
      )
    end

    def school_sections(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/schools/#{id}/sections",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end

    def school_terms(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/schools/#{id}/terms",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end

    # role - acceptable values are nil, :staff, :student, :teacher
    # primary - acceptable values are nil, true
    def school_users(access_token:, id:, role: nil, primary: nil, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/schools/#{id}/users",
        params: params(role: role, primary: primary,
          limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end
    # def school_staff(access_token:, id:, primary: nil, limit: nil, starting_after: nil, ending_before: nil)
    # def school_students(access_token:, id:, primary: nil, limit: nil, starting_after: nil, ending_before: nil)
    # def school_teachers(access_token:, id:, primary: nil, limit: nil, starting_after: nil, ending_before: nil)

    # count - acceptable values are nil, :true, :false, :undefined
    def sections(access_token:, limit: nil, starting_after: nil, ending_before: nil, count: nil)
      get(
        "https://api.clever.com/v3.0/sections",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before, count: count),
        headers: bearer_headers(access_token)
      )
    end

    def section(access_token:, id:)
      get(
        "https://api.clever.com/v3.0/sections/#{id}",
        headers: bearer_headers(access_token)
      )
    end

    def section_course(access_token:, id:)
      get(
        "https://api.clever.com/v3.0/sections/#{id}/course",
        headers: bearer_headers(access_token)
      )
    end

    def section_district(access_token:, id:)
      get(
        "https://api.clever.com/v3.0/sections/#{id}/district",
        headers: bearer_headers(access_token)
      )
    end

    def section_resources(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/sections/#{id}/resources",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end

    def section_school(access_token:, id:)
      get(
        "https://api.clever.com/v3.0/sections/#{id}/school",
        headers: bearer_headers(access_token)
      )
    end

    def section_term(access_token:, id:)
      get(
        "https://api.clever.com/v3.0/sections/#{id}/term",
        headers: bearer_headers(access_token)
      )
    end

    # role - acceptable values are nil, :student, :teacher
    def section_users(access_token:, id:, role: nil, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/sections/#{id}/users",
        params: params(role: role, limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end
    # def section_students(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
    # def section_teachers(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)

    # count - acceptable values are nil, :true, :false, :undefined
    def terms(access_token:, limit: nil, starting_after: nil, ending_before: nil, count: nil)
      get(
        "https://api.clever.com/v3.0/terms",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before, count: count),
        headers: bearer_headers(access_token)
      )
    end

    def term(access_token:, id:)
      get(
        "https://api.clever.com/v3.0/terms/#{id}",
        headers: bearer_headers(access_token)
      )
    end

    def term_district(access_token:, id:)
      get(
        "https://api.clever.com/v3.0/terms/#{id}/district",
        headers: bearer_headers(access_token)
      )
    end

    def term_mycontacts(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/terms/#{id}/mycontacts",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end

    def term_mystudents(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/terms/#{id}/mystudents",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end

    def term_myteachers(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/terms/#{id}/myteachers",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end

    def term_resources(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/terms/#{id}/resources",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end

    # primary - acceptable values are nil, true
    def term_schools(access_token:, id:, primary: nil, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/terms/#{id}/schools",
        params: params(primary: primary, limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end

    def term_sections(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/terms/#{id}/sections",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end

    # role - acceptable values are nil, :contact, :district_admin, :staff, :student, :teacher
    # count - acceptable values are nil, :true, :false, :undefined
    def users(access_token:, role: nil, limit: nil, starting_after: nil, ending_before: nil, count: nil)
      get(
        "https://api.clever.com/v3.0/users",
        params: params(role: role, limit: limit, starting_after: starting_after, ending_before: ending_before,
          count: count),
        headers: bearer_headers(access_token)
      )
    end

    def user(access_token:, id:)
      get(
        "https://api.clever.com/v3.0/users/#{id}",
        headers: bearer_headers(access_token)
      )
    end

    def user_district(access_token:, id:)
      get(
        "https://api.clever.com/v3.0/users/#{id}/district",
        headers: bearer_headers(access_token)
      )
    end

    def user_resources(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
      get(
        "https://api.clever.com/v3.0/users/#{id}/resources",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
        headers: bearer_headers(access_token)
      )
    end

    def events(access_token:, limit: nil, starting_after: nil, ending_before: nil, school: nil, record_type: nil)
      record_type = Array(record_type).flatten.compact
      record_type = nil if record_type.empty?

      get(
        "https://api.clever.com/v3.0/events",
        params: params(limit: limit, starting_after: starting_after, ending_before: ending_before,
          school: school, record_type: record_type),
        headers: bearer_headers(access_token)
      )
    end

    def event(access_token:, id:)
      get(
        "https://api.clever.com/v3.0/events/#{id}",
        headers: bearer_headers(access_token)
      )
    end

    def page(access_token:, path:)
      get(
        "https://api.clever.com#{path}",
        headers: bearer_headers(access_token)
      )
    end

    private

    def get url, **kwargs
      run(url, method: :get, **kwargs)
    end

    def post url, **kwargs
      run(url, method: :post, **kwargs)
    end

    def run url, **kwargs
      CleverApi::Api::Response.handle(
        Typhoeus::Request.new(url, **kwargs).run
      )
    end

    def params **kwargs
      kwargs.delete_if { |_k, v| v.nil? }
    end

    def basic_auth_token(client_id, client_secret)
      Base64.strict_encode64([client_id, client_secret].join(":"))
    end

    def basic_auth_headers(client_id, client_secret)
      {
        "Accept" => "application/json",
        "Authorization" => "Basic #{basic_auth_token(client_id, client_secret)}"
      }
    end

    def bearer_headers(access_token)
      {
        "Accept" => "application/json",
        "Authorization" => "Bearer #{access_token}"
      }
    end
  end
end

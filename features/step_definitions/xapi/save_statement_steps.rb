# encoding: UTF-8

def create_minimal_statement
  {}
end

def create_typical_statement
  {}
end

def create_save_statement_context(type)
  context = {
      'resource' => 'statements',
      'method' => 'POST',
      'headers' => {
          'X-Experience-API-Version' => '1.0.1',
          'Content-Type' => 'application/json'
      },
      'content' => ''
  }
  case type
    when 'minimal'
      context.merge!(
                 {
                     'content' =>
                      {
                          'actor' => {
                              'mbox' => 'mailto:conformancetest@tincanapi.com',
                              'objectType' => 'Agent'
                          },
                          'verb' =>  {
                              'id' => 'http://tincanapi.com/conformancetest/verbid',
                              'display' => {
                                  'en-US' => 'test'
                              }
                          },
                          'object' => {
                              'id' => 'http://tincanapi.com/conformancetest/activityid',
                              'objectType' => 'Activity'
                          }
                      }
                 }
      )
    when 'typical'
      id = SecureRandom.uuid
      context.merge!({
                         'method' => 'PUT',
                         'content' =>
                             {
                                 'actor' => {
                                     'mbox' => 'mailto:conformancetest@tincanapi.com',
                                     'objectType' => 'Agent'
                                 },
                                 'verb' =>  {
                                     'id' => 'http://tincanapi.com/conformancetest/verbid',
                                     'display' => {
                                         'en-US' => 'test'
                                     }
                                 },
                                 'object' => {
                                     'id' => 'http://tincanapi.com/conformancetest/activityid',
                                     'objectType' => 'Activity'
                                 },
                                 'id' => id,
                                 'timestamp' => '2014-07-23T12:34:02-05:00'
                             },
                         'params' => {
                             'statementId' => id
                         }
                     })
    when 'attachment'
      {}
  end
  context
end

Given(/^a \[(.*?)\] saveStatement request$/) do |type|
  @lrs = FactoryGirl.create(:lrs)
  @context = create_save_statement_context(type)
  if @context['headers']
    @context['headers'].each_pair do |key, value|
      header(key, value) if value
    end
  end
  basic_authorize(@lrs.api['basic_key'], @lrs.api['basic_secret'])
end

Given(/^the \[content\] is set to '\[null\]'$/) do
  pending # express the regexp above with the code you wish you had
end


module Fondue
  # A basic hash-centric class implementation.
  # Extend it and specify a hash_attribute, to which all missing methods will be delegated to.
  # If no hash attribute is specified, it is inferred from the class name
  # Example:
  #   class MyDataContainer < Fondue::HashClass
  #     hash_attribute :data
  #   end
  #   
  #   c = MyDataContainer.new(:data => {:foo => 'bar'})
  #   c.map { |k,v| puts "#{k} => #{v}" }
  #   #=> "foo => bar"
  #   c[:foo]
  #   #=> 'bar'
  #   c.foo
  #   #=> 'bar'
  class HashClass
    def initialize options = {}
      options.map do |k,v| 
        self.class.send(:attr_accessor,k.to_sym) unless respond_to?(:"#{k}=")
        send(:"#{k}=",v)
      end
    end
    
    def method_missing name, *args, &block
      hash = instance_variable_get(self.class.get_hash_attribute)
      if hash.respond_to?(name)
        hash.send(name,*args)
      elsif hash.key?(name)
        hash[name]
      elsif hash.key?(name.to_s)
        hash[name.to_s]
      else
        super
      end
    end
    
    class << self
      
      def hash_attribute attr_name
        @hash_attribute = "@#{attr_name}"
      end
      
      def get_hash_attribute
        if @hash_attribute and @hash_attribute != ''
          @hash_attribute
        else
          "@#{stringify(self.to_s)}"
        end
      end
      
      def stringify klass
        string = klass.to_s.split('::').last
        string.gsub(/([A-Z][a-z]*)/,'_\1').gsub(/^_/,'').downcase
      end
    end
  end
end
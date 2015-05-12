class Factory
  def self.new(*args)
    new_object = Class.new do
      define_method :initialize do |*values|
        values.each_with_index do |value, index|
          instance_variable_set(:"@#{args[index]}", value)
          self.class.send(:attr_accessor, args[index])
        end
      end

      define_method :inspect do
        vars = -> (k) { '%s="%s"' % [k[1..-1], instance_variable_get(k)] }
        '<struct %s %s>' % [self.class, instance_variables.map(&vars).join(' ')]
      end

      define_method :[] do |arg|
        return instance_variable_get(instance_variables[arg]) if arg.is_a? Fixnum
        instance_variable_get(:"@#{arg}")
      end

      define_method :== do |obj|
        obj1 = instance_variables.map{ |var| instance_variable_get var }
        obj2 = obj.instance_variables.map{ |var| obj.instance_variable_get var }
        obj1 == obj2
      end
    end

    Object.const_set(args.shift, new_object) if args.first.is_a? String

    new_object
  end
end

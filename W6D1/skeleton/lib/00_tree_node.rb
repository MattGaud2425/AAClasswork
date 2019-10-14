require "byebug"
class PolyTreeNode

    attr_reader :value, :children, :parent

    def initialize value = nil 
        @value = value 
        @parent = nil 
        @children = []
    end


    def parent=(property)
        @parent.children.delete(self) unless @parent == nil
        @parent = property
        @parent.children << self unless @parent == nil
    end

    def add_child(child) 
        child.parent = self
    end

    def remove_child(child)
        raise "error" if !@children.include?(child)
        child.parent = nil
    end

    def dfs(target_value)
        #debugger
        return self if self.value == target_value
        self.children.each do |child|
            result = child.dfs(target_value)
            return result unless result.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = []
        queue << self
        until queue.empty?
            node = queue.shift
            return node if target_value == node.value
            queue += node.children
        end

    end

end



# See the Pagy documentation: https://ddnexus.github.io/pagy/extras/searchkick

class Pagy
  # Add specialized backend methods to paginate Searchkick::Results
  module Backend ; private
    # Return Pagy object and items
    def pagy_searchkick(results, vars={})
      pagy = Pagy.new(pagy_searchkick_get_vars(results, vars))
      return pagy, results[pagy.offset, pagy.items]
    end

    def pagy_searchkick_get_vars(results, vars)
      # Return the merged variables to initialize the Pagy object
      { count: results.is_a?(Array) ? results.sum(&:total_count) : results.total_count,
        page:  params[vars[:page_param]||VARS[:page_param]],
      }.merge!(vars)
    end
  end
end

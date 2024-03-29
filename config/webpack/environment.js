const { environment } = require('@rails/webpacker')

const webpack = require('webpack')

environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery',
        'window.jQuery': 'jquery'
    })
)
const aliasConfig = {
    'jquery': 'jquery/src/jquery'
}

environment.config.set('resolve.alias', aliasConfig);

module.exports = environment

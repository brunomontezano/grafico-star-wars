# ---------------------------
# Desafio 3 - Blog da Curso-R
# ---------------------------

# Carregar a base de dados do Star Wars
dados <- dados::dados_starwars

# Baixar e salvar o background no diretório atual
#download.file(
#    url = "https://wallpaperaccess.com/full/11836.jpg",
#    destfile = "fundo.jpg"
#)

# Carregar tema do pacote cowplot
# Possui um quadro semi-aberto e não tem grid
ggplot2::theme_set(cowplot::theme_cowplot())

# Criar gráfico base
grafico <- dados |>
    # Eixo x: massa; eixo y: altura
    ggplot2::ggplot(ggplot2::aes(x = massa, y = altura)) +
    # Aumentar tamanho do ponto, preencher e contornar
    # de amarelo, mudar forma para losango e adicionar
    # transparência
    ggplot2::geom_point(
        size = 2,
        fill = "yellow",
        color = "yellow",
        shape = 23,
        alpha = 0.8
        ) +
    # Modificar os limites do eixo x para retirar
    # um outlier da massa (Jabba Desilijic Tiure)
    ggplot2::scale_x_continuous(limits = c(0, 200)) +
    ggplot2::geom_point(
        data = dplyr::filter(dados, nome == "Darth Vader"),
        shape = 23,
        fill = "red",
        size = 2,
        alpha = 0.8,
        color = "red") +
    # Adicionar rótulo para dar realce ao Darth Vader,
    # assim como pintar seu ponto de vermelho
    # Também se utiliza a fonte Star Jedi aqui, e o mesmo
    # processo de uso do argumento family se repete no código
    ggplot2::geom_label(
        data = dplyr::filter(dados, nome == "Darth Vader"),
             ggplot2::aes(label = "darth vader"), #Devido a fonte
             fill = "red",
             nudge_x = -10,
             nudge_y = 10,
             family = "Star Jedi") +
    # Modifica os rótulos de cada eixo, assim como o título e
    # subtítulo do plot
    ggplot2::labs(
        title = "STAR WARS",
        subtitle = "may the force be with you"
        ) +
    ggplot2::theme(
        # Modificar todos os textos para utilizar a fonte e a cor desejada
        text = ggplot2::element_text(family = "Star Jedi", color = "yellow"),
        # Ajustar posição e cor do título
        plot.title = ggplot2::element_text(
            family = "Star Jedi", color = "yellow", hjust = 0.5
        ),
        # Ajustar posição e cor do subtítulo
        plot.subtitle = ggplot2::element_text(
            family = "Star Jedi", colour = "yellow", hjust = 0.5
        ),
        # Retirar linhas dos eixos
        axis.line = ggplot2::element_blank(),
        # Retirar ticks dos eixos
        axis.ticks = ggplot2::element_blank(),
        # Mudar fonte e cor do texto dos eixos
        axis.text = ggplot2::element_text(
            family = "Star Jedi", colour = "yellow"
        )
    )

# Adicionar fundo no plot
grafico_com_fundo <- cowplot::ggdraw() +
    cowplot::draw_image("fundo.jpg") +
    cowplot::draw_plot(
        plot = grafico,
        scale = 0.9
    )

# Salvar versão final do plot
cowplot::save_plot(
    filename = "plot_final.png",
    plot = grafico_com_fundo,
    base_width = 10,
    base_height = 10 / 1.618
)

import { departements } from './data.js';
import { departements_data } from './data.js';

export const departementsMap = function () {
    let bbx;
    let bby;
    let bbX = 0;
    let bbY = 0;

    const bbox = function (node, id) {
        console.log(id);
        const bbox = node.getBBox();

        d3.select('svg')
            .selectAll(".select-departement")
            .remove();

        d3.select('svg')
            .append("rect")
            .attr('class', 'select-departement')
            .attr("x", bbox.x)
            .attr("y", bbox.y)
            .attr("width", bbox.width)
            .attr("height", bbox.height)
            .style("fill", "none")
            //---
            //.style("fill-opacity", ".3")
            .style("stroke", "red")
            .style("stroke-width", 1);

        //----
        const path = departements_data["d" + id].path;
        const translateX = bbX - bbox.x;
        const translateY = bbY - bbox.y;

        d3.select('svg')
            .append("path")
            .style("fill", "red")
            .attr('class', 'select-departement')
            .attr('d', path)
            .transition()
            .duration(750)
            .ease(d3.easeExp)
            .attr("transform", "translate(" + translateX + "," + translateY + ")");
    }


    const layout = function () {
        const path = d3.select(this);
        const node = path.node();
        const bbox = node.getBBox();
        console.log("bbox.x" + bbox.x);
        if (bbx) {
            bbx = Math.min(bbx, bbox.x);
            bby = Math.min(bby, bbox.y);
        } else {
            //first time
            bbx = bbox.x;
            bby = bbox.y;
        }
        bbX = Math.max(bbX, bbox.x + bbox.width);
        bbY = Math.max(bbY, bbox.y + bbox.height);
    }

    const draw = function () {
        d3.select('svg')
            .append('g')
            .selectAll('path')
            .data(departements)
            .enter()
            .append('path')
            .attr('d', d => {
                const id = "d" + d;
                return departements_data[id].path;
            })
            .attr('id', d => { return d; })
            .attr('fill', '#ddd')
            .attr('stroke', 'white')
            .attr('stroke-width', 1)
            .on('mouseover', function (d, i) {
                d3.select(this)
                    .attr('fill', '#aaa');
            })
            .on('mouseout', function (d, i) {
                d3.select(this)
                    .attr('fill', '#ddd');
            })
            .on('click', function (d, i) {
                const selection = d3.select(this);
                const id = selection.attr('id');
                const node = selection.node(d);
                bbox(node, id);
            })
            .each(layout);

        d3.select('svg')
            .append("rect")
            //        .attr('class', 'select-departement')
            .attr("x", bbx)
            .attr("y", bby)
            .attr("width", bbX - bbx)
            .attr("height", bbY - bby)
            .style("fill", "none")
            //    .style("fill-opacity", ".3")
            .style("stroke", "red")
            .style("stroke-width", 1);
    }

    return Object.freeze({
        //On freeze l'objet et on ne publie qu'une seule méthode.
        draw
    });
}
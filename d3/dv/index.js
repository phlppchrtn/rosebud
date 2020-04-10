import { alphabetFonts } from "./data.js";

const font2Data = (font) => {
  const elts = font.elts;
  const _data = [];
  for (const elt of elts) {
    const obj2 = {};
    obj2.x = 10 * elt.x;
    obj2.y = 10 * elt.y;
    _data.push(obj2);
  }
  return _data;
}

const findFont = (letter) => {
  let fontIdx = letter;
  if (letter === ' ') {
    fontIdx = "sp";
  }
  if (letter === '!') {
    fontIdx = "ex";
  }
  return alphabetFonts[fontIdx];
}

export const writeText = (text)  => {
  const letters = text.split('');
  const padding = 10;
  let offset = 10;
  const y = 10;
  d3.select("svg")
    .selectAll('g')
    .data(letters)
    .enter()
    .append('g')
    .each(function (d, i) {
      const r = 3;
      const font = findFont(d); //d is a letter
      const _data = font2Data(font);
      const group = d3
        .select(this)
        .attr('transform', 'translate(' + offset + ',' + y + ')');

      group.append('rect')
        .attr('x', 0)
        .attr('y', 0)
        .attr('width', font.width * 10)
        .attr('height', font.height * 10)
        .attr('fill', '#ccc')
        .on('mouseover', function (p, j) {
          d3.selectAll('.g' + i)
            .style('fill', 'orange');
        })
        .on('mouseout', function (p, j) {
          d3.selectAll('.g' + i)
            .style('fill', 'darkblue');
        });

      group.selectAll('circle')
        .data(_data)
        .enter()
        .append('circle')
        .attr('class', (p, j) => { return "g" + i; })
        .attr('r', r)
        .attr('cx', function (d) { return d.x; })
        .attr('cy', function (d) { return d.y; })
        .style('fill', 'darkblue');

      offset = offset + font.width * 10 + padding;
      console.log("offset :" + offset + ", y:" + y);
    });
}
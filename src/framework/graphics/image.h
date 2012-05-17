/*
 * Copyright (c) 2010-2012 OTClient <https://github.com/edubart/otclient>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#ifndef IMAGE_H
#define IMAGE_H

#include "declarations.h"
#include <framework/util/databuffer.h>

class Image
{
public:
    Image(const Size& size, int bpp = 4, uint8 *pixels = nullptr);

    static ImagePtr load(const std::string& file);
    static ImagePtr loadPNG(const std::string& file);

    void overwriteMask(const Color& maskedColor, const Color& insideColor = Color::white, const Color& outsideColor = Color::alpha);
    void append(const Point& dest, const ImagePtr &other);

    std::vector<uint8>& getPixels() { return m_pixels; }
    uint8* getPixelData() { return &m_pixels[0]; }
    int getPixelCount() { return m_size.area(); }
    const Size& getSize() { return m_size; }
    int getWidth() { return m_size.width(); }
    int getHeight() { return m_size.height(); }
    int getBpp() { return m_bpp; }
    uint8* getPixel(int x, int y) { return &m_pixels[(y * m_size.width() + x) * 4]; }

private:
    std::vector<uint8> m_pixels;
    Size m_size;
    int m_bpp;
};

#endif
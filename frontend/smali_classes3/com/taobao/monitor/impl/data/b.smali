.class public Lcom/taobao/monitor/impl/data/b;
.super Ljava/lang/Object;
.source "CanvasCalculator.java"

# interfaces
.implements Lcom/taobao/monitor/impl/data/e;


# instance fields
.field private a:J

.field private final a:Landroid/view/View;

.field private a:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet<",
            "Landroid/graphics/drawable/Drawable;",
            ">;"
        }
    .end annotation
.end field

.field private a:Z

.field private final b:Landroid/view/View;


# direct methods
.method public constructor <init>(Landroid/view/View;Landroid/view/View;)V
    .locals 2

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/b;->a:Ljava/util/HashSet;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/b;->a:Z

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/taobao/monitor/impl/data/b;->a:J

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/b;->a:Landroid/view/View;

    iput-object p2, p0, Lcom/taobao/monitor/impl/data/b;->b:Landroid/view/View;

    return-void
.end method

.method private a(Landroid/view/View;Ljava/util/List;)F
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/view/View;",
            "Ljava/util/List<",
            "Lcom/taobao/monitor/impl/data/k;",
            ">;)F"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/b;->b:Landroid/view/View;

    .line 1
    invoke-static {p1, v0}, Lcom/taobao/monitor/impl/data/l;->a(Landroid/view/View;Landroid/view/View;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    .line 5
    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result v0

    sget v2, Lcom/taobao/monitor/impl/data/l;->b:I

    div-int/lit8 v2, v2, 0x14

    const/high16 v3, 0x3f800000    # 1.0f

    if-ge v0, v2, :cond_2

    iget-boolean p2, p0, Lcom/taobao/monitor/impl/data/b;->a:Z

    if-nez p2, :cond_1

    .line 6
    invoke-direct {p0, p1}, Lcom/taobao/monitor/impl/data/b;->a(Landroid/view/View;)Z

    move-result p1

    if-eqz p1, :cond_1

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/data/b;->a:Z

    :cond_1
    return v3

    .line 14
    :cond_2
    invoke-virtual {p1}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_3

    return v1

    .line 19
    :cond_3
    instance-of v0, p1, Landroid/view/ViewStub;

    if-eqz v0, :cond_4

    return v1

    .line 23
    :cond_4
    instance-of v0, p1, Landroid/view/ViewGroup;

    if-eqz v0, :cond_19

    .line 24
    move-object v0, p1

    check-cast v0, Landroid/view/ViewGroup;

    .line 25
    instance-of v2, v0, Landroid/webkit/WebView;

    if-eqz v2, :cond_6

    .line 27
    sget-object p1, Lcom/taobao/monitor/impl/data/c;->a:Lcom/taobao/monitor/impl/data/c;

    check-cast v0, Landroid/webkit/WebView;

    invoke-virtual {p1, v0}, Lcom/taobao/monitor/impl/data/AbsWebView;->isWebViewLoadFinished(Landroid/view/View;)Z

    move-result p1

    if-eqz p1, :cond_5

    return v3

    :cond_5
    return v1

    .line 31
    :cond_6
    sget-object v2, Lcom/taobao/monitor/impl/data/WebViewProxy;->INSTANCE:Lcom/taobao/monitor/impl/data/WebViewProxy;

    invoke-virtual {v2, v0}, Lcom/taobao/monitor/impl/data/WebViewProxy;->isWebView(Landroid/view/View;)Z

    move-result v4

    if-eqz v4, :cond_8

    .line 33
    invoke-virtual {v2, v0}, Lcom/taobao/monitor/impl/data/WebViewProxy;->isWebViewLoadFinished(Landroid/view/View;)Z

    move-result p1

    if-eqz p1, :cond_7

    return v3

    :cond_7
    return v1

    .line 39
    :cond_8
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/l;->a(Landroid/view/ViewGroup;)[Landroid/view/View;

    move-result-object v2

    if-nez v2, :cond_9

    return v1

    .line 47
    :cond_9
    array-length v1, v2

    const/4 v4, 0x0

    move v5, v4

    move v6, v5

    move v7, v6

    :goto_0
    const v8, 0x3f4ccccd    # 0.8f

    if-ge v5, v1, :cond_d

    aget-object v9, v2, v5

    if-nez v9, :cond_a

    goto :goto_2

    :cond_a
    add-int/lit8 v6, v6, 0x1

    .line 53
    new-instance v10, Ljava/util/ArrayList;

    invoke-direct {v10}, Ljava/util/ArrayList;-><init>()V

    .line 54
    invoke-direct {p0, v9, v10}, Lcom/taobao/monitor/impl/data/b;->a(Landroid/view/View;Ljava/util/List;)F

    move-result v11

    cmpl-float v8, v11, v8

    if-lez v8, :cond_b

    add-int/lit8 v7, v7, 0x1

    iget-object v8, p0, Lcom/taobao/monitor/impl/data/b;->b:Landroid/view/View;

    .line 57
    invoke-static {v9, v8}, Lcom/taobao/monitor/impl/data/k;->a(Landroid/view/View;Landroid/view/View;)Lcom/taobao/monitor/impl/data/k;

    move-result-object v8

    .line 58
    invoke-interface {p2, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 59
    invoke-virtual {v10}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :goto_1
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_c

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lcom/taobao/monitor/impl/data/k;

    .line 60
    invoke-virtual {v9}, Lcom/taobao/monitor/impl/data/k;->a()V

    goto :goto_1

    .line 63
    :cond_b
    invoke-interface {p2, v10}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :cond_c
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 67
    :cond_d
    :goto_2
    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result v1

    sget v2, Lcom/taobao/monitor/impl/data/l;->b:I

    div-int/lit8 v2, v2, 0x8

    if-ge v1, v2, :cond_f

    instance-of v1, v0, Landroid/widget/LinearLayout;

    if-nez v1, :cond_e

    instance-of v1, v0, Landroid/widget/RelativeLayout;

    if-eqz v1, :cond_f

    :cond_e
    if-ne v6, v7, :cond_f

    if-eqz v6, :cond_f

    return v3

    .line 74
    :cond_f
    new-instance v1, Lcom/taobao/monitor/impl/data/g;

    const/16 v2, 0x1e

    invoke-static {v2}, Lcom/taobao/monitor/impl/util/b;->a(I)I

    move-result v2

    invoke-direct {v1, v2}, Lcom/taobao/monitor/impl/data/g;-><init>(I)V

    iget-object v2, p0, Lcom/taobao/monitor/impl/data/b;->b:Landroid/view/View;

    .line 75
    invoke-virtual {v1, v0, p2, v2}, Lcom/taobao/monitor/impl/data/g;->a(Landroid/view/View;Ljava/util/List;Landroid/view/View;)F

    move-result v1

    cmpl-float v2, v1, v8

    if-lez v2, :cond_10

    return v3

    .line 81
    :cond_10
    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result v2

    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result v5

    mul-int/2addr v2, v5

    sget v5, Lcom/taobao/monitor/impl/data/l;->a:I

    const/4 v6, 0x3

    div-int/2addr v5, v6

    sget v7, Lcom/taobao/monitor/impl/data/l;->b:I

    mul-int/2addr v5, v7

    div-int/lit8 v5, v5, 0x4

    if-gt v2, v5, :cond_18

    .line 82
    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result v2

    sget v5, Lcom/taobao/monitor/impl/data/l;->a:I

    div-int/2addr v5, v6

    if-lt v2, v5, :cond_11

    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result p1

    sget v2, Lcom/taobao/monitor/impl/data/l;->b:I

    div-int/lit8 v2, v2, 0x4

    if-ge p1, v2, :cond_18

    :cond_11
    iget-object p1, p0, Lcom/taobao/monitor/impl/data/b;->b:Landroid/view/View;

    .line 83
    invoke-static {v0, p1}, Lcom/taobao/monitor/impl/data/k;->a(Landroid/view/View;Landroid/view/View;)Lcom/taobao/monitor/impl/data/k;

    move-result-object p1

    .line 85
    iget v0, p1, Lcom/taobao/monitor/impl/data/k;->a:I

    iget v2, p1, Lcom/taobao/monitor/impl/data/k;->b:I

    add-int/2addr v0, v2

    div-int/lit8 v0, v0, 0x2

    .line 86
    iget v2, p1, Lcom/taobao/monitor/impl/data/k;->c:I

    iget p1, p1, Lcom/taobao/monitor/impl/data/k;->d:I

    add-int/2addr v2, p1

    div-int/lit8 v2, v2, 0x2

    .line 91
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    move p2, v4

    :cond_12
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_18

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/taobao/monitor/impl/data/k;

    .line 92
    iget v7, v5, Lcom/taobao/monitor/impl/data/k;->a:I

    if-ge v7, v0, :cond_13

    iget v8, v5, Lcom/taobao/monitor/impl/data/k;->b:I

    if-ge v0, v8, :cond_13

    iget v8, v5, Lcom/taobao/monitor/impl/data/k;->c:I

    if-ge v8, v2, :cond_13

    iget v8, v5, Lcom/taobao/monitor/impl/data/k;->d:I

    if-ge v2, v8, :cond_13

    return v3

    .line 98
    :cond_13
    iget v8, v5, Lcom/taobao/monitor/impl/data/k;->b:I

    add-int/2addr v7, v8

    div-int/lit8 v7, v7, 0x2

    .line 99
    iget v8, v5, Lcom/taobao/monitor/impl/data/k;->c:I

    iget v5, v5, Lcom/taobao/monitor/impl/data/k;->d:I

    add-int/2addr v8, v5

    div-int/lit8 v8, v8, 0x2

    if-gt v0, v7, :cond_14

    or-int/lit8 v4, v4, 0x1

    int-to-byte v4, v4

    :cond_14
    if-lt v0, v7, :cond_15

    or-int/lit8 v4, v4, 0x2

    int-to-byte v4, v4

    :cond_15
    if-gt v2, v8, :cond_16

    or-int/lit8 p2, p2, 0x1

    int-to-byte p2, p2

    :cond_16
    if-lt v2, v8, :cond_17

    or-int/lit8 p2, p2, 0x2

    int-to-byte p2, p2

    :cond_17
    if-ne v4, v6, :cond_12

    if-ne p2, v6, :cond_12

    return v3

    :cond_18
    return v1

    .line 125
    :cond_19
    instance-of p2, p1, Landroid/widget/ImageView;

    if-eqz p2, :cond_1e

    .line 127
    move-object p2, p1

    check-cast p2, Landroid/widget/ImageView;

    invoke-virtual {p2}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object p2

    .line 129
    instance-of v0, p2, Landroid/graphics/drawable/DrawableWrapper;

    if-eqz v0, :cond_1a

    .line 130
    check-cast p2, Landroid/graphics/drawable/DrawableWrapper;

    invoke-virtual {p2}, Landroid/graphics/drawable/DrawableWrapper;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object p2

    .line 134
    :cond_1a
    invoke-direct {p0, p2}, Lcom/taobao/monitor/impl/data/b;->a(Landroid/graphics/drawable/Drawable;)Z

    move-result v0

    if-eqz v0, :cond_1b

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/b;->a:Ljava/util/HashSet;

    .line 135
    invoke-virtual {v0, p2}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1b

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/b;->a:Ljava/util/HashSet;

    .line 136
    invoke-virtual {p1, p2}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    return v3

    .line 141
    :cond_1b
    invoke-virtual {p1}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object p1

    .line 143
    instance-of v0, p1, Landroid/graphics/drawable/DrawableWrapper;

    if-eqz v0, :cond_1c

    .line 144
    check-cast p2, Landroid/graphics/drawable/DrawableWrapper;

    invoke-virtual {p2}, Landroid/graphics/drawable/DrawableWrapper;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object p1

    .line 148
    :cond_1c
    invoke-direct {p0, p1}, Lcom/taobao/monitor/impl/data/b;->a(Landroid/graphics/drawable/Drawable;)Z

    move-result p2

    if-eqz p2, :cond_1d

    iget-object p2, p0, Lcom/taobao/monitor/impl/data/b;->a:Ljava/util/HashSet;

    .line 149
    invoke-virtual {p2, p1}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_1d

    iget-object p2, p0, Lcom/taobao/monitor/impl/data/b;->a:Ljava/util/HashSet;

    .line 150
    invoke-virtual {p2, p1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    return v3

    :cond_1d
    return v1

    .line 155
    :cond_1e
    instance-of p2, p1, Landroid/widget/TextView;

    if-eqz p2, :cond_21

    .line 156
    instance-of p2, p1, Landroid/widget/EditText;

    if-eqz p2, :cond_1f

    .line 158
    invoke-virtual {p1}, Landroid/view/View;->isFocusable()Z

    move-result p1

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/data/b;->a:Z

    return v3

    .line 162
    :cond_1f
    check-cast p1, Landroid/widget/TextView;

    invoke-virtual {p1}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-eqz p1, :cond_20

    return v1

    :cond_20
    return v3

    .line 166
    :cond_21
    instance-of p2, p1, Landroid/view/TextureView;

    if-eqz p2, :cond_22

    .line 167
    check-cast p1, Landroid/view/TextureView;

    invoke-virtual {p1}, Landroid/view/TextureView;->getSurfaceTexture()Landroid/graphics/SurfaceTexture;

    move-result-object p1

    if-eqz p1, :cond_22

    .line 169
    invoke-virtual {p1}, Landroid/graphics/SurfaceTexture;->getTimestamp()J

    move-result-wide p1

    iput-wide p1, p0, Lcom/taobao/monitor/impl/data/b;->a:J

    const-string v0, "surfaceTextureTimestamp"

    .line 170
    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    filled-new-array {v0, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p2, "DrawCalculator2"

    invoke-static {p2, p1}, Lcom/taobao/monitor/impl/logger/Logger;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_22
    return v3
.end method

.method private a(Landroid/graphics/drawable/Drawable;)Z
    .locals 1

    .line 180
    instance-of v0, p1, Landroid/graphics/drawable/BitmapDrawable;

    if-nez v0, :cond_1

    instance-of v0, p1, Landroid/graphics/drawable/NinePatchDrawable;

    if-nez v0, :cond_1

    instance-of v0, p1, Landroid/graphics/drawable/AnimationDrawable;

    if-nez v0, :cond_1

    instance-of v0, p1, Landroid/graphics/drawable/ShapeDrawable;

    if-nez v0, :cond_1

    instance-of v0, p1, Landroid/graphics/drawable/PictureDrawable;

    if-nez v0, :cond_1

    instance-of v0, p1, Landroid/graphics/drawable/ColorDrawable;

    if-nez v0, :cond_1

    .line 186
    invoke-direct {p0, p1}, Lcom/taobao/monitor/impl/data/b;->b(Landroid/graphics/drawable/Drawable;)Z

    move-result p1

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p1, 0x1

    :goto_1
    return p1
.end method

.method private a(Landroid/view/View;)Z
    .locals 3

    .line 171
    instance-of v0, p1, Landroid/widget/EditText;

    if-eqz v0, :cond_0

    .line 172
    invoke-virtual {p1}, Landroid/view/View;->isFocusable()Z

    move-result p1

    return p1

    .line 173
    :cond_0
    instance-of v0, p1, Landroid/view/ViewGroup;

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    .line 174
    check-cast p1, Landroid/view/ViewGroup;

    move v0, v1

    .line 176
    :goto_0
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v2

    if-eq v0, v2, :cond_2

    .line 177
    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    .line 179
    invoke-direct {p0, v2}, Lcom/taobao/monitor/impl/data/b;->a(Landroid/view/View;)Z

    move-result v2

    if-eqz v2, :cond_1

    const/4 p1, 0x1

    return p1

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    return v1
.end method

.method private b(Landroid/graphics/drawable/Drawable;)Z
    .locals 8

    const-string v0, "DrawCalculator2"

    const/4 v1, 0x0

    if-nez p1, :cond_0

    return v1

    .line 1
    :cond_0
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "com.facebook.drawee.generic.RootDrawable"

    invoke-static {v2, v3}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1

    return v1

    .line 5
    :cond_1
    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getCurrent()Landroid/graphics/drawable/Drawable;

    move-result-object p1

    .line 6
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "com.facebook.drawee.drawable.FadeDrawable"

    invoke-static {v2, v3}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_2

    return v1

    .line 11
    :cond_2
    :try_start_0
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v3, "getNumberOfLayers"

    :try_start_1
    new-array v4, v1, [Ljava/lang/Class;

    .line 12
    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3
    :try_end_1
    .catch Ljava/lang/NoSuchMethodException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/lang/IllegalAccessException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    const-string v4, "getDrawable"

    const/4 v5, 0x1

    :try_start_2
    new-array v6, v5, [Ljava/lang/Class;

    .line 13
    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v1

    invoke-virtual {v2, v4, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    new-array v4, v1, [Ljava/lang/Object;

    .line 14
    invoke-virtual {v3, p1, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    move v4, v1

    :goto_0
    if-eq v4, v3, :cond_4

    new-array v6, v5, [Ljava/lang/Object;

    .line 17
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v6, v1

    invoke-virtual {v2, p1, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    .line 18
    instance-of v7, v6, Landroid/graphics/drawable/Drawable;

    if-eqz v7, :cond_3

    .line 19
    check-cast v6, Landroid/graphics/drawable/Drawable;

    invoke-virtual {v6}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v6
    :try_end_2
    .catch Ljava/lang/NoSuchMethodException; {:try_start_2 .. :try_end_2} :catch_3
    .catch Ljava/lang/IllegalAccessException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    if-lez v6, :cond_3

    return v5

    :cond_3
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :catch_0
    move-exception p1

    .line 31
    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {v0, p1}, Lcom/taobao/monitor/impl/logger/Logger;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1

    :catch_1
    move-exception p1

    .line 32
    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {v0, p1}, Lcom/taobao/monitor/impl/logger/Logger;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1

    :catch_2
    move-exception p1

    .line 33
    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {v0, p1}, Lcom/taobao/monitor/impl/logger/Logger;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1

    :catch_3
    move-exception p1

    .line 34
    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {v0, p1}, Lcom/taobao/monitor/impl/logger/Logger;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_4
    :goto_1
    return v1
.end method


# virtual methods
.method public a()F
    .locals 6

    .line 187
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/b;->a:Landroid/view/View;

    .line 188
    invoke-direct {p0, v1, v0}, Lcom/taobao/monitor/impl/data/b;->a(Landroid/view/View;Ljava/util/List;)F

    move-result v1

    .line 190
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/taobao/monitor/impl/data/k;

    .line 191
    invoke-virtual {v2}, Lcom/taobao/monitor/impl/data/k;->a()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/b;->a:Ljava/util/HashSet;

    .line 193
    invoke-virtual {v0}, Ljava/util/HashSet;->clear()V

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/data/b;->a:Z

    if-nez v0, :cond_1

    iget-wide v2, p0, Lcom/taobao/monitor/impl/data/b;->a:J

    const-wide/16 v4, 0x0

    cmp-long v0, v2, v4

    if-lez v0, :cond_2

    :cond_1
    const/high16 v1, 0x3f800000    # 1.0f

    :cond_2
    return v1
.end method

.class Lcom/taobao/monitor/impl/data/l;
.super Ljava/lang/Object;
.source "ViewUtils.java"


# static fields
.field static a:I

.field private static a:Ljava/lang/reflect/Field;

.field static b:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->context()Landroid/content/Context;

    move-result-object v0

    const-string v1, "window"

    .line 2
    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    .line 3
    invoke-virtual {v0}, Landroid/view/Display;->getHeight()I

    move-result v1

    sput v1, Lcom/taobao/monitor/impl/data/l;->b:I

    .line 4
    invoke-virtual {v0}, Landroid/view/Display;->getWidth()I

    move-result v0

    sput v0, Lcom/taobao/monitor/impl/data/l;->a:I

    .line 7
    :try_start_0
    const-class v0, Landroid/view/ViewGroup;

    const-string v1, "mChildren"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    sput-object v0, Lcom/taobao/monitor/impl/data/l;->a:Ljava/lang/reflect/Field;

    const/4 v1, 0x1

    .line 8
    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 10
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :goto_0
    return-void
.end method

.method static a(Landroid/view/View;Landroid/view/View;)Z
    .locals 5

    .line 12
    invoke-static {p0, p1}, Lcom/taobao/monitor/impl/data/l;->a(Landroid/view/View;Landroid/view/View;)[I

    move-result-object p1

    const/4 v0, 0x1

    .line 14
    aget v1, p1, v0

    .line 15
    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    move-result v2

    add-int/2addr v2, v1

    const/4 v3, 0x0

    .line 17
    aget p1, p1, v3

    .line 18
    invoke-virtual {p0}, Landroid/view/View;->getWidth()I

    move-result p0

    add-int/2addr p0, p1

    sget v4, Lcom/taobao/monitor/impl/data/l;->b:I

    if-ge v1, v4, :cond_0

    if-lez v2, :cond_0

    if-lez p0, :cond_0

    sget p0, Lcom/taobao/monitor/impl/data/l;->a:I

    if-ge p1, p0, :cond_0

    sub-int/2addr v2, v1

    if-lez v2, :cond_0

    goto :goto_0

    :cond_0
    move v0, v3

    :goto_0
    return v0
.end method

.method static a(Landroid/view/View;Landroid/view/View;)[I
    .locals 5

    const/4 v0, 0x0

    filled-new-array {v0, v0}, [I

    move-result-object v1

    :goto_0
    if-eq p0, p1, :cond_0

    const/4 v2, 0x1

    .line 26
    aget v3, v1, v2

    invoke-virtual {p0}, Landroid/view/View;->getTop()I

    move-result v4

    add-int/2addr v3, v4

    aput v3, v1, v2

    .line 27
    aget v3, v1, v0

    invoke-virtual {p0}, Landroid/view/View;->getLeft()I

    move-result v4

    add-int/2addr v3, v4

    aput v3, v1, v0

    .line 28
    invoke-virtual {p0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object p0

    .line 29
    instance-of v3, p0, Landroid/view/View;

    if-eqz v3, :cond_0

    .line 30
    aget v3, v1, v2

    check-cast p0, Landroid/view/View;

    invoke-virtual {p0}, Landroid/view/View;->getScrollY()I

    move-result v4

    sub-int/2addr v3, v4

    aput v3, v1, v2

    .line 31
    aget v2, v1, v0

    invoke-virtual {p0}, Landroid/view/View;->getScrollX()I

    move-result v3

    sub-int/2addr v2, v3

    aput v2, v1, v0

    goto :goto_0

    :cond_0
    return-object v1
.end method

.method static a(Landroid/view/ViewGroup;)[Landroid/view/View;
    .locals 4

    :try_start_0
    sget-object v0, Lcom/taobao/monitor/impl/data/l;->a:Ljava/lang/reflect/Field;

    .line 1
    invoke-virtual {v0, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Landroid/view/View;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object v0

    .line 7
    :catchall_0
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    if-lez v0, :cond_1

    .line 9
    new-array v1, v0, [Landroid/view/View;

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_0

    .line 11
    invoke-virtual {p0, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    aput-object v3, v1, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    return-object v1

    :cond_1
    const/4 p0, 0x0

    return-object p0
.end method

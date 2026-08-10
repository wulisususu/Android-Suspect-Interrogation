.class public Lcom/alibaba/sdk/android/push/common/global/b;
.super Ljava/lang/Object;


# static fields
.field static volatile a:Ljava/lang/String; = null

.field static volatile b:Landroid/graphics/Bitmap; = null

.field static volatile c:Ljava/lang/Class; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field static volatile d:I = 0x0

.field static volatile e:I = 0x0

.field static volatile f:I = 0x0

.field static volatile g:Z = false

.field static volatile h:Ljava/util/Random;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public static a()Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/push/common/global/b;->a:Ljava/lang/String;

    return-object v0
.end method

.method public static b()Landroid/graphics/Bitmap;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/push/common/global/b;->b:Landroid/graphics/Bitmap;

    return-object v0
.end method

.method public static c()I
    .locals 1

    sget v0, Lcom/alibaba/sdk/android/push/common/global/b;->d:I

    return v0
.end method

.method public static d()Z
    .locals 1

    sget-boolean v0, Lcom/alibaba/sdk/android/push/common/global/b;->g:Z

    return v0
.end method

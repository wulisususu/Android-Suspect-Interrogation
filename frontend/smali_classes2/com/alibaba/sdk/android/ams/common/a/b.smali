.class public Lcom/alibaba/sdk/android/ams/common/a/b;
.super Ljava/lang/Object;


# direct methods
.method public static a(Landroid/app/Application;)V
    .locals 0

    if-nez p0, :cond_0

    return-void

    :cond_0
    sput-object p0, Lcom/alibaba/sdk/android/ams/common/a/a;->b:Landroid/app/Application;

    return-void
.end method

.method public static a(Landroid/content/Context;)V
    .locals 1

    if-eqz p0, :cond_0

    sput-object p0, Lcom/alibaba/sdk/android/ams/common/a/a;->a:Landroid/content/Context;

    return-void

    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "null applicationContext!"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static a(Ljava/lang/String;)V
    .locals 0

    sput-object p0, Lcom/alibaba/sdk/android/ams/common/a/a;->d:Ljava/lang/String;

    return-void
.end method

.method public static a(Z)V
    .locals 0

    sput-boolean p0, Lcom/alibaba/sdk/android/ams/common/a/a;->c:Z

    return-void
.end method

.method public static b(Ljava/lang/String;)V
    .locals 0

    sput-object p0, Lcom/alibaba/sdk/android/ams/common/a/a;->e:Ljava/lang/String;

    return-void
.end method

.method public static c(Ljava/lang/String;)V
    .locals 0

    sput-object p0, Lcom/alibaba/sdk/android/ams/common/a/a;->f:Ljava/lang/String;

    return-void
.end method

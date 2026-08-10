.class public Lcom/aliyun/emas/apm/crash/a;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field public final a:Ljava/lang/String;

.field public final b:Ljava/lang/String;

.field public final c:Ljava/lang/String;

.field public final d:Ljava/lang/String;

.field public final e:Ljava/lang/String;

.field public final f:Lcom/aliyun/emas/apm/crash/x;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/aliyun/emas/apm/crash/x;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/a;->a:Ljava/lang/String;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/a;->b:Ljava/lang/String;

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/a;->c:Ljava/lang/String;

    iput-object p4, p0, Lcom/aliyun/emas/apm/crash/a;->d:Ljava/lang/String;

    iput-object p5, p0, Lcom/aliyun/emas/apm/crash/a;->e:Ljava/lang/String;

    iput-object p6, p0, Lcom/aliyun/emas/apm/crash/a;->f:Lcom/aliyun/emas/apm/crash/x;

    return-void
.end method

.method public static a(Landroid/content/Context;Lcom/aliyun/emas/apm/crash/b0;Ljava/lang/String;Lcom/aliyun/emas/apm/crash/x;)Lcom/aliyun/emas/apm/crash/a;
    .locals 7

    .line 1
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    .line 2
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/b0;->e()Ljava/lang/String;

    move-result-object v1

    .line 3
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object p0

    const/4 p1, 0x0

    .line 4
    invoke-virtual {p0, v2, p1}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object p0

    .line 5
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/a;->a(Landroid/content/pm/PackageInfo;)Ljava/lang/String;

    move-result-object v3

    .line 7
    iget-object p0, p0, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;

    if-nez p0, :cond_0

    const-string p0, "0.0"

    :cond_0
    move-object v4, p0

    .line 9
    new-instance p0, Lcom/aliyun/emas/apm/crash/a;

    move-object v0, p0

    move-object v5, p2

    move-object v6, p3

    invoke-direct/range {v0 .. v6}, Lcom/aliyun/emas/apm/crash/a;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/aliyun/emas/apm/crash/x;)V

    return-object p0
.end method

.method private static a(Landroid/content/pm/PackageInfo;)Ljava/lang/String;
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_0

    .line 11
    invoke-virtual {p0}, Landroid/content/pm/PackageInfo;->getLongVersionCode()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 13
    :cond_0
    iget p0, p0, Landroid/content/pm/PackageInfo;->versionCode:I

    invoke-static {p0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

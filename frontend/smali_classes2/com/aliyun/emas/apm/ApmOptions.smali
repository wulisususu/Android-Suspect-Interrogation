.class public Lcom/aliyun/emas/apm/ApmOptions;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/ApmOptions$Builder;
    }
.end annotation


# static fields
.field public static final NO_DEVICE_DATA:I = 0x1

.field public static final NO_NETWORK_DATA:I = 0x4

.field public static final NO_OS_DATA:I = 0x2


# instance fields
.field private final a:Landroid/app/Application;

.field private final b:Ljava/lang/String;

.field private final c:Ljava/lang/String;

.field private final d:Ljava/lang/String;

.field private final e:Ljava/util/List;

.field private final f:Ljava/util/List;

.field private final g:Ljava/lang/String;

.field private final h:Ljava/lang/String;

.field private final i:Ljava/lang/String;

.field private final j:Z

.field private k:Ljava/lang/Boolean;

.field private final l:I


# direct methods
.method private constructor <init>(Landroid/app/Application;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLjava/util/List;I)V
    .locals 1

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions;->k:Ljava/lang/Boolean;

    iput-object p1, p0, Lcom/aliyun/emas/apm/ApmOptions;->a:Landroid/app/Application;

    iput-object p2, p0, Lcom/aliyun/emas/apm/ApmOptions;->b:Ljava/lang/String;

    iput-object p3, p0, Lcom/aliyun/emas/apm/ApmOptions;->c:Ljava/lang/String;

    iput-object p4, p0, Lcom/aliyun/emas/apm/ApmOptions;->d:Ljava/lang/String;

    iput-object p5, p0, Lcom/aliyun/emas/apm/ApmOptions;->e:Ljava/util/List;

    iput-object p6, p0, Lcom/aliyun/emas/apm/ApmOptions;->g:Ljava/lang/String;

    iput-object p7, p0, Lcom/aliyun/emas/apm/ApmOptions;->h:Ljava/lang/String;

    iput-object p8, p0, Lcom/aliyun/emas/apm/ApmOptions;->i:Ljava/lang/String;

    iput-boolean p9, p0, Lcom/aliyun/emas/apm/ApmOptions;->j:Z

    iput-object p10, p0, Lcom/aliyun/emas/apm/ApmOptions;->f:Ljava/util/List;

    iput p11, p0, Lcom/aliyun/emas/apm/ApmOptions;->l:I

    return-void
.end method

.method synthetic constructor <init>(Landroid/app/Application;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLjava/util/List;ILcom/aliyun/emas/apm/ApmOptions$a;)V
    .locals 0

    .line 1
    invoke-direct/range {p0 .. p11}, Lcom/aliyun/emas/apm/ApmOptions;-><init>(Landroid/app/Application;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLjava/util/List;I)V

    return-void
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/ApmOptions;)Landroid/app/Application;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/ApmOptions;->a:Landroid/app/Application;

    return-object p0
.end method

.method static synthetic b(Lcom/aliyun/emas/apm/ApmOptions;)Ljava/lang/String;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/ApmOptions;->b:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic c(Lcom/aliyun/emas/apm/ApmOptions;)Z
    .locals 0

    .line 1
    iget-boolean p0, p0, Lcom/aliyun/emas/apm/ApmOptions;->j:Z

    return p0
.end method

.method static synthetic d(Lcom/aliyun/emas/apm/ApmOptions;)Ljava/lang/String;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/ApmOptions;->c:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic e(Lcom/aliyun/emas/apm/ApmOptions;)Ljava/lang/String;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/ApmOptions;->d:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic f(Lcom/aliyun/emas/apm/ApmOptions;)Ljava/util/List;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/ApmOptions;->e:Ljava/util/List;

    return-object p0
.end method

.method static synthetic g(Lcom/aliyun/emas/apm/ApmOptions;)Ljava/lang/String;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/ApmOptions;->g:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic h(Lcom/aliyun/emas/apm/ApmOptions;)Ljava/lang/String;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/ApmOptions;->h:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic i(Lcom/aliyun/emas/apm/ApmOptions;)Ljava/lang/String;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/ApmOptions;->i:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic j(Lcom/aliyun/emas/apm/ApmOptions;)I
    .locals 0

    .line 1
    iget p0, p0, Lcom/aliyun/emas/apm/ApmOptions;->l:I

    return p0
.end method

.method static synthetic k(Lcom/aliyun/emas/apm/ApmOptions;)Ljava/util/List;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/ApmOptions;->f:Ljava/util/List;

    return-object p0
.end method


# virtual methods
.method public getAppKey()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions;->b:Ljava/lang/String;

    return-object v0
.end method

.method public getAppRsaSecret()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions;->d:Ljava/lang/String;

    return-object v0
.end method

.method public getAppSecret()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions;->c:Ljava/lang/String;

    return-object v0
.end method

.method public getApplication()Landroid/app/Application;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions;->a:Landroid/app/Application;

    return-object v0
.end method

.method public getApplicationId()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions;->a:Landroid/app/Application;

    .line 1
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getChannel()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions;->i:Ljava/lang/String;

    return-object v0
.end method

.method public getComponents()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/Class<",
            "+",
            "Lcom/aliyun/emas/apm/BaseComponent;",
            ">;>;"
        }
    .end annotation

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions;->e:Ljava/util/List;

    return-object v0
.end method

.method public getNoCollectionDataType()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/ApmOptions;->l:I

    return v0
.end method

.method public getProductOptions()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/aliyun/emas/apm/ApmProductOptions;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions;->f:Ljava/util/List;

    return-object v0
.end method

.method public getUserId()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions;->g:Ljava/lang/String;

    return-object v0
.end method

.method public getUserNick()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions;->h:Ljava/lang/String;

    return-object v0
.end method

.method public isOnline()Z
    .locals 4

    const-string v0, "emas_apm_pre_enable"

    iget-object v1, p0, Lcom/aliyun/emas/apm/ApmOptions;->k:Ljava/lang/Boolean;

    if-eqz v1, :cond_0

    .line 2
    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    return v0

    .line 5
    :cond_0
    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    iput-object v1, p0, Lcom/aliyun/emas/apm/ApmOptions;->k:Ljava/lang/Boolean;

    iget-object v1, p0, Lcom/aliyun/emas/apm/ApmOptions;->a:Landroid/app/Application;

    .line 6
    invoke-virtual {v1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    if-eqz v1, :cond_1

    :try_start_0
    iget-object v2, p0, Lcom/aliyun/emas/apm/ApmOptions;->a:Landroid/app/Application;

    .line 9
    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0x80

    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 10
    iget-object v2, v1, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    if-eqz v2, :cond_1

    invoke-virtual {v2, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 11
    iget-object v1, v1, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    invoke-virtual {v1, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions;->k:Ljava/lang/Boolean;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions;->k:Ljava/lang/Boolean;

    .line 18
    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    return v0
.end method

.method public isOpenDebug()Z
    .locals 1

    iget-boolean v0, p0, Lcom/aliyun/emas/apm/ApmOptions;->j:Z

    return v0
.end method

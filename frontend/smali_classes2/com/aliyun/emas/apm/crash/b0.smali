.class public Lcom/aliyun/emas/apm/crash/b0;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final g:Ljava/util/regex/Pattern;

.field private static final h:Ljava/lang/String;


# instance fields
.field private final a:Lcom/aliyun/emas/apm/crash/c0;

.field private final b:Landroid/content/Context;

.field private final c:Ljava/lang/String;

.field private final d:Ljava/lang/String;

.field private final e:Ljava/lang/String;

.field private final f:Lcom/aliyun/emas/apm/ApmSession;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "[^\\p{Alnum}]"

    .line 1
    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/b0;->g:Ljava/util/regex/Pattern;

    const-string v0, "/"

    .line 3
    invoke-static {v0}, Ljava/util/regex/Pattern;->quote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/b0;->h:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/aliyun/emas/apm/ApmSession;Lcom/aliyun/emas/apm/crash/u;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    if-eqz p1, :cond_1

    if-eqz p2, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/b0;->b:Landroid/content/Context;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/b0;->c:Ljava/lang/String;

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/b0;->d:Ljava/lang/String;

    iput-object p4, p0, Lcom/aliyun/emas/apm/crash/b0;->e:Ljava/lang/String;

    iput-object p5, p0, Lcom/aliyun/emas/apm/crash/b0;->f:Lcom/aliyun/emas/apm/ApmSession;

    .line 14
    new-instance p1, Lcom/aliyun/emas/apm/crash/c0;

    invoke-direct {p1}, Lcom/aliyun/emas/apm/crash/c0;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/b0;->a:Lcom/aliyun/emas/apm/crash/c0;

    return-void

    .line 15
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string p2, "appIdentifier must not be null"

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 16
    :cond_1
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string p2, "appContext must not be null"

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/b0;->f:Lcom/aliyun/emas/apm/ApmSession;

    .line 1
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/ApmSession;->getSessionId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/b0;->c:Ljava/lang/String;

    return-object v0
.end method

.method public c()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/b0;->d:Ljava/lang/String;

    return-object v0
.end method

.method public d()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/b0;->e:Ljava/lang/String;

    return-object v0
.end method

.method public e()Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/b0;->a:Lcom/aliyun/emas/apm/crash/c0;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/b0;->b:Landroid/content/Context;

    .line 1
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/c0;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public f()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/b0;->b:Landroid/content/Context;

    .line 1
    invoke-static {v0}, Lcom/ut/device/UTDevice;->getUtdid(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

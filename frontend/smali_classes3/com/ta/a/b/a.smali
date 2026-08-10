.class public Lcom/ta/a/b/a;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field public a:I

.field public a:Ljava/lang/String;

.field public b:J

.field public data:[B

.field public timestamp:J


# direct methods
.method public constructor <init>()V
    .locals 3

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Lcom/ta/a/b/a;->a:I

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/ta/a/b/a;->timestamp:J

    const-string v2, ""

    iput-object v2, p0, Lcom/ta/a/b/a;->a:Ljava/lang/String;

    const/4 v2, 0x0

    iput-object v2, p0, Lcom/ta/a/b/a;->data:[B

    iput-wide v0, p0, Lcom/ta/a/b/a;->b:J

    return-void
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 6

    const-string v0, ""

    const/4 v1, 0x0

    .line 21
    :try_start_0
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1

    const/4 v2, 0x4

    new-array v2, v2, [Ljava/lang/Object;

    const-string v3, "result"

    aput-object v3, v2, v1

    const/4 v3, 0x1

    aput-object p0, v2, v3

    const-string v4, "signature"

    const/4 v5, 0x2

    aput-object v4, v2, v5

    const/4 v4, 0x3

    aput-object p1, v2, v4

    .line 22
    invoke-static {v0, v2}, Lcom/ta/a/c/f;->b(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 23
    invoke-static {p0}, Lcom/ta/a/c/b;->d(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 24
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object p0

    invoke-static {p0, v5}, Lcom/ta/utdid2/a/a/a;->encodeToString([BI)Ljava/lang/String;

    move-result-object p0

    .line 25
    invoke-virtual {p1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    new-array p0, v3, [Ljava/lang/Object;

    const-string p1, "signature is ok"

    aput-object p1, p0, v1

    .line 26
    invoke-static {v0, p0}, Lcom/ta/a/c/f;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    return v3

    :cond_0
    new-array p0, v3, [Ljava/lang/Object;

    const-string p1, "signature is error"

    aput-object p1, p0, v1

    .line 29
    invoke-static {v0, p0}, Lcom/ta/a/c/f;->a(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p0

    .line 33
    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object p0

    invoke-static {v0, p0}, Lcom/ta/a/c/f;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1
    :goto_0
    return v1
.end method

.class public Lcom/ta/utdid2/device/e;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method public static a(Lcom/ta/a/b/a;)Z
    .locals 3

    .line 10
    :try_start_0
    new-instance v0, Ljava/lang/String;

    iget-object v1, p0, Lcom/ta/a/b/a;->data:[B

    const-string v2, "UTF-8"

    invoke-direct {v0, v1, v2}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 12
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, ""

    invoke-static {v1, v0}, Lcom/ta/a/c/f;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    move-object v0, v1

    .line 14
    :goto_0
    iget-object p0, p0, Lcom/ta/a/b/a;->a:Ljava/lang/String;

    invoke-static {v0, p0}, Lcom/ta/a/b/a;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    .line 15
    invoke-static {v0}, Lcom/ta/utdid2/device/b;->a(Ljava/lang/String;)Lcom/ta/utdid2/device/b;

    move-result-object p0

    iget p0, p0, Lcom/ta/utdid2/device/b;->d:I

    invoke-static {p0}, Lcom/ta/utdid2/device/b;->a(I)Z

    move-result p0

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

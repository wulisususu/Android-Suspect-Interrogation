.class Lcom/aliyun/emas/apm/crash/f0;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final b:Ljava/nio/charset/Charset;


# instance fields
.field private final a:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "UTF-8"

    .line 1
    invoke-static {v0}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/f0;->b:Ljava/nio/charset/Charset;

    return-void
.end method

.method public constructor <init>(Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/f0;->a:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    return-void
.end method

.method private static a(Lcom/aliyun/emas/apm/crash/b1;)Ljava/lang/String;
    .locals 1

    .line 97
    new-instance v0, Lcom/aliyun/emas/apm/crash/f0$a;

    invoke-direct {v0, p0}, Lcom/aliyun/emas/apm/crash/f0$a;-><init>(Lcom/aliyun/emas/apm/crash/b1;)V

    .line 107
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static a(Lcom/aliyun/emas/apm/crash/k0;)Ljava/lang/String;
    .locals 1

    .line 108
    new-instance v0, Lcom/aliyun/emas/apm/crash/f0$b;

    invoke-direct {v0, p0}, Lcom/aliyun/emas/apm/crash/f0$b;-><init>(Lcom/aliyun/emas/apm/crash/k0;)V

    .line 118
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static a(Ljava/util/List;)Ljava/lang/String;
    .locals 6

    .line 120
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 121
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    const/4 v2, 0x0

    .line 122
    :goto_0
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v3

    if-ge v2, v3, :cond_0

    .line 123
    sget-object v3, Lcom/aliyun/emas/apm/crash/s0;->a:Lcom/google/firebase/encoders/DataEncoder;

    .line 124
    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    invoke-interface {v3, v4}, Lcom/google/firebase/encoders/DataEncoder;->encode(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 126
    :try_start_0
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4, v3}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v3

    .line 128
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v4

    const-string v5, "Exception parsing rollout assignment!"

    invoke-virtual {v4, v5, v3}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    const-string p0, "rolloutsState"

    .line 131
    invoke-virtual {v0, p0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 133
    new-instance p0, Lorg/json/JSONObject;

    invoke-direct {p0, v0}, Lorg/json/JSONObject;-><init>(Ljava/util/Map;)V

    invoke-virtual {p0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static a(Ljava/util/Map;)Ljava/lang/String;
    .locals 1

    .line 119
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p0}, Lorg/json/JSONObject;-><init>(Ljava/util/Map;)V

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static a(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 134
    invoke-virtual {p0, p1}, Lorg/json/JSONObject;->isNull(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    invoke-virtual {p0, p1, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :cond_0
    return-object v1
.end method

.method private static a(Ljava/io/File;)V
    .locals 3

    .line 135
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Ljava/io/File;->delete()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 136
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Deleted corrupt file: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->i(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method private static f(Ljava/lang/String;)Ljava/util/Map;
    .locals 4

    .line 1
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 2
    new-instance p0, Ljava/util/HashMap;

    invoke-direct {p0}, Ljava/util/HashMap;-><init>()V

    .line 3
    invoke-virtual {v0}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v1

    .line 4
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 5
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 6
    invoke-static {v0, v2}, Lcom/aliyun/emas/apm/crash/f0;->a(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-interface {p0, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_0
    return-object p0
.end method

.method private static g(Ljava/lang/String;)Ljava/util/List;
    .locals 7

    .line 1
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string p0, "rolloutsState"

    .line 2
    invoke-virtual {v0, p0}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p0

    .line 3
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const/4 v1, 0x0

    .line 5
    :goto_0
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v2

    if-ge v1, v2, :cond_0

    .line 6
    invoke-virtual {p0, v1}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v2

    .line 9
    :try_start_0
    invoke-static {v2}, Lcom/aliyun/emas/apm/crash/s0;->a(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/s0;

    move-result-object v3

    .line 10
    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v3

    .line 12
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "Failed de-serializing rollouts state. "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v2, v3}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-object v0
.end method


# virtual methods
.method public a(Ljava/lang/String;)Ljava/io/File;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/f0;->a:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    const-string v1, "internal-keys"

    .line 96
    invoke-virtual {v0, p1, v1}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getSessionFile(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    return-object p1
.end method

.method a(Ljava/lang/String;Z)Ljava/util/Map;
    .locals 6

    const-string v0, "Failed to close user metadata file."

    if-eqz p2, :cond_0

    .line 49
    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    goto :goto_0

    :cond_0
    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/crash/f0;->b(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    .line 50
    :goto_0
    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p2

    if-eqz p2, :cond_2

    invoke-virtual {p1}, Ljava/io/File;->length()J

    move-result-wide v1

    const-wide/16 v3, 0x0

    cmp-long p2, v1, v3

    if-nez p2, :cond_1

    goto :goto_3

    :cond_1
    const/4 p2, 0x0

    .line 57
    :try_start_0
    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, p1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 58
    :try_start_1
    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lcom/aliyun/emas/apm/crash/f0;->f(Ljava/lang/String;)Ljava/util/Map;

    move-result-object p1
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 63
    invoke-static {v1, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    return-object p1

    :catchall_0
    move-exception p1

    move-object p2, v1

    goto :goto_2

    :catch_0
    move-exception p2

    move-object v5, v1

    move-object v1, p2

    move-object p2, v5

    goto :goto_1

    :catchall_1
    move-exception p1

    goto :goto_2

    :catch_1
    move-exception v1

    .line 64
    :goto_1
    :try_start_2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v2

    const-string v3, "Error deserializing user metadata."

    invoke-virtual {v2, v3, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 65
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/io/File;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 67
    invoke-static {p2, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    .line 69
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object p1

    return-object p1

    .line 70
    :goto_2
    invoke-static {p2, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    .line 71
    throw p1

    .line 72
    :cond_2
    :goto_3
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/io/File;)V

    .line 73
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object p1

    return-object p1
.end method

.method public a(Ljava/lang/String;Lcom/aliyun/emas/apm/crash/b1;)V
    .locals 5

    const-string v0, "Failed to close user metadata file."

    .line 1
    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/crash/f0;->e(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    const/4 v1, 0x0

    .line 4
    :try_start_0
    invoke-static {p2}, Lcom/aliyun/emas/apm/crash/f0;->a(Lcom/aliyun/emas/apm/crash/b1;)Ljava/lang/String;

    move-result-object p2

    .line 5
    new-instance v2, Ljava/io/BufferedWriter;

    new-instance v3, Ljava/io/OutputStreamWriter;

    new-instance v4, Ljava/io/FileOutputStream;

    invoke-direct {v4, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    sget-object p1, Lcom/aliyun/emas/apm/crash/f0;->b:Ljava/nio/charset/Charset;

    invoke-direct {v3, v4, p1}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/nio/charset/Charset;)V

    invoke-direct {v2, v3}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 6
    :try_start_1
    invoke-virtual {v2, p2}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 7
    invoke-virtual {v2}, Ljava/io/Writer;->flush()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception p1

    goto :goto_3

    :catch_0
    move-exception p1

    move-object v1, v2

    goto :goto_0

    :catchall_1
    move-exception p1

    goto :goto_2

    :catch_1
    move-exception p1

    .line 12
    :goto_0
    :try_start_2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p2

    const-string v2, "Error serializing user metadata."

    invoke-virtual {p2, v2, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-object v2, v1

    .line 11
    :goto_1
    invoke-static {v2, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    return-void

    :goto_2
    move-object v2, v1

    .line 14
    :goto_3
    invoke-static {v2, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    .line 15
    throw p1
.end method

.method public a(Ljava/lang/String;Lcom/aliyun/emas/apm/crash/k0;)V
    .locals 5

    const-string v0, "Failed to close network metadata file."

    .line 16
    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/crash/f0;->c(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    const/4 v1, 0x0

    .line 19
    :try_start_0
    invoke-static {p2}, Lcom/aliyun/emas/apm/crash/f0;->a(Lcom/aliyun/emas/apm/crash/k0;)Ljava/lang/String;

    move-result-object p2

    .line 20
    new-instance v2, Ljava/io/BufferedWriter;

    new-instance v3, Ljava/io/OutputStreamWriter;

    new-instance v4, Ljava/io/FileOutputStream;

    invoke-direct {v4, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    sget-object p1, Lcom/aliyun/emas/apm/crash/f0;->b:Ljava/nio/charset/Charset;

    invoke-direct {v3, v4, p1}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/nio/charset/Charset;)V

    invoke-direct {v2, v3}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 21
    :try_start_1
    invoke-virtual {v2, p2}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 22
    invoke-virtual {v2}, Ljava/io/Writer;->flush()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception p1

    goto :goto_3

    :catch_0
    move-exception p1

    move-object v1, v2

    goto :goto_0

    :catchall_1
    move-exception p1

    goto :goto_2

    :catch_1
    move-exception p1

    .line 27
    :goto_0
    :try_start_2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p2

    const-string v2, "Error serializing network metadata."

    invoke-virtual {p2, v2, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-object v2, v1

    .line 26
    :goto_1
    invoke-static {v2, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    return-void

    :goto_2
    move-object v2, v1

    .line 29
    :goto_3
    invoke-static {v2, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    .line 30
    throw p1
.end method

.method public a(Ljava/lang/String;Ljava/util/List;)V
    .locals 6

    const-string v0, "Failed to close rollouts state file."

    .line 74
    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/crash/f0;->d(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    .line 75
    invoke-interface {p2}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 76
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/io/File;)V

    return-void

    :cond_0
    const/4 v1, 0x0

    .line 82
    :try_start_0
    invoke-static {p2}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/util/List;)Ljava/lang/String;

    move-result-object p2

    .line 83
    new-instance v2, Ljava/io/BufferedWriter;

    new-instance v3, Ljava/io/OutputStreamWriter;

    new-instance v4, Ljava/io/FileOutputStream;

    invoke-direct {v4, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    sget-object v5, Lcom/aliyun/emas/apm/crash/f0;->b:Ljava/nio/charset/Charset;

    invoke-direct {v3, v4, v5}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/nio/charset/Charset;)V

    invoke-direct {v2, v3}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 84
    :try_start_1
    invoke-virtual {v2, p2}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 85
    invoke-virtual {v2}, Ljava/io/Writer;->flush()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception p1

    move-object v1, v2

    goto :goto_2

    :catch_0
    move-exception p2

    move-object v1, v2

    goto :goto_0

    :catchall_1
    move-exception p1

    goto :goto_2

    :catch_1
    move-exception p2

    .line 91
    :goto_0
    :try_start_2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v2

    const-string v3, "Error serializing rollouts state."

    invoke-virtual {v2, v3, p2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 92
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/io/File;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-object v2, v1

    .line 90
    :goto_1
    invoke-static {v2, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    return-void

    .line 94
    :goto_2
    invoke-static {v1, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    .line 95
    throw p1
.end method

.method public a(Ljava/lang/String;Ljava/util/Map;)V
    .locals 1

    const/4 v0, 0x0

    .line 31
    invoke-virtual {p0, p1, p2, v0}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/lang/String;Ljava/util/Map;Z)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/util/Map;Z)V
    .locals 5

    const-string v0, "Failed to close key/value metadata file."

    if-eqz p3, :cond_0

    .line 32
    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    goto :goto_0

    :cond_0
    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/crash/f0;->b(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    :goto_0
    const/4 p3, 0x0

    .line 35
    :try_start_0
    invoke-static {p2}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/util/Map;)Ljava/lang/String;

    move-result-object p2

    .line 36
    new-instance v1, Ljava/io/BufferedWriter;

    new-instance v2, Ljava/io/OutputStreamWriter;

    new-instance v3, Ljava/io/FileOutputStream;

    invoke-direct {v3, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    sget-object v4, Lcom/aliyun/emas/apm/crash/f0;->b:Ljava/nio/charset/Charset;

    invoke-direct {v2, v3, v4}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/nio/charset/Charset;)V

    invoke-direct {v1, v2}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 37
    :try_start_1
    invoke-virtual {v1, p2}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 38
    invoke-virtual {v1}, Ljava/io/Writer;->flush()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_2

    :catchall_0
    move-exception p1

    move-object p3, v1

    goto :goto_3

    :catch_0
    move-exception p2

    move-object p3, v1

    goto :goto_1

    :catchall_1
    move-exception p1

    goto :goto_3

    :catch_1
    move-exception p2

    .line 44
    :goto_1
    :try_start_2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v1

    const-string v2, "Error serializing key/value metadata."

    invoke-virtual {v1, v2, p2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 45
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/io/File;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-object v1, p3

    .line 43
    :goto_2
    invoke-static {v1, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    return-void

    .line 47
    :goto_3
    invoke-static {p3, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    .line 48
    throw p1
.end method

.method public b(Ljava/lang/String;)Ljava/io/File;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/f0;->a:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    const-string v1, "keys"

    .line 1
    invoke-virtual {v0, p1, v1}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getSessionFile(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    return-object p1
.end method

.method public c(Ljava/lang/String;)Ljava/io/File;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/f0;->a:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    const-string v1, "network-data"

    .line 1
    invoke-virtual {v0, p1, v1}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getSessionFile(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    return-object p1
.end method

.method public d(Ljava/lang/String;)Ljava/io/File;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/f0;->a:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    const-string v1, "rollouts-state"

    .line 1
    invoke-virtual {v0, p1, v1}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getSessionFile(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    return-object p1
.end method

.method public e(Ljava/lang/String;)Ljava/io/File;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/f0;->a:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    const-string v1, "user-data"

    .line 1
    invoke-virtual {v0, p1, v1}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getSessionFile(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    return-object p1
.end method

.method public h(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/k0;
    .locals 8

    const-string v0, "Failed to close network metadata file."

    .line 1
    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/crash/f0;->c(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    .line 2
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_1

    invoke-virtual {v1}, Ljava/io/File;->length()J

    move-result-wide v4

    const-wide/16 v6, 0x0

    cmp-long v2, v4, v6

    if-nez v2, :cond_0

    goto :goto_2

    .line 10
    :cond_0
    :try_start_0
    new-instance p1, Ljava/io/FileInputStream;

    invoke-direct {p1, v1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 11
    :try_start_1
    new-instance v2, Lorg/json/JSONObject;

    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v4}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 12
    new-instance v4, Lcom/aliyun/emas/apm/crash/k0;

    invoke-direct {v4}, Lcom/aliyun/emas/apm/crash/k0;-><init>()V

    const-string v5, "carrier"

    .line 13
    invoke-static {v2, v5}, Lcom/aliyun/emas/apm/crash/f0;->a(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/aliyun/emas/apm/crash/k0;->b(Ljava/lang/String;)V

    const-string v5, "access"

    .line 14
    invoke-static {v2, v5}, Lcom/aliyun/emas/apm/crash/f0;->a(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v2}, Lcom/aliyun/emas/apm/crash/k0;->a(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 20
    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    return-object v4

    :catch_0
    move-exception v2

    goto :goto_0

    :catchall_0
    move-exception p1

    goto :goto_1

    :catch_1
    move-exception p1

    move-object v2, p1

    move-object p1, v3

    .line 21
    :goto_0
    :try_start_2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v4

    const-string v5, "Error deserializing network metadata."

    invoke-virtual {v4, v5, v2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 22
    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/io/File;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 24
    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    return-object v3

    :catchall_1
    move-exception v1

    move-object v3, p1

    move-object p1, v1

    .line 25
    :goto_1
    invoke-static {v3, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    .line 26
    throw p1

    .line 27
    :cond_1
    :goto_2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v4, "No networkInfo set for session "

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    .line 28
    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/io/File;)V

    return-object v3
.end method

.method public i(Ljava/lang/String;)Ljava/util/List;
    .locals 7

    const-string v0, "Failed to close rollouts state file."

    const-string v1, "Loaded rollouts state:\n"

    .line 1
    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/crash/f0;->d(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    .line 2
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-virtual {v2}, Ljava/io/File;->length()J

    move-result-wide v3

    const-wide/16 v5, 0x0

    cmp-long v3, v3, v5

    if-nez v3, :cond_0

    goto :goto_3

    :cond_0
    const/4 v3, 0x0

    .line 9
    :try_start_0
    new-instance v4, Ljava/io/FileInputStream;

    invoke-direct {v4, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 10
    :try_start_1
    invoke-static {v4}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/aliyun/emas/apm/crash/f0;->g(Ljava/lang/String;)Ljava/util/List;

    move-result-object v3

    .line 11
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v6, "\nfor session "

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 12
    invoke-virtual {v5, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 18
    invoke-static {v4, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    return-object v3

    :catchall_0
    move-exception p1

    goto :goto_2

    :catch_0
    move-exception p1

    move-object v3, v4

    goto :goto_0

    :catchall_1
    move-exception p1

    goto :goto_1

    :catch_1
    move-exception p1

    .line 19
    :goto_0
    :try_start_2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v1

    const-string v4, "Error deserializing rollouts state."

    invoke-virtual {v1, v4, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 20
    invoke-static {v2}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/io/File;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 22
    invoke-static {v3, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    .line 24
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object p1

    return-object p1

    :goto_1
    move-object v4, v3

    .line 25
    :goto_2
    invoke-static {v4, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    .line 26
    throw p1

    .line 27
    :cond_1
    :goto_3
    invoke-static {v2}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/io/File;)V

    .line 28
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method public j(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/b1;
    .locals 8

    const-string v0, "Failed to close user metadata file."

    .line 1
    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/crash/f0;->e(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    .line 2
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_1

    invoke-virtual {v1}, Ljava/io/File;->length()J

    move-result-wide v4

    const-wide/16 v6, 0x0

    cmp-long v2, v4, v6

    if-nez v2, :cond_0

    goto :goto_2

    .line 10
    :cond_0
    :try_start_0
    new-instance p1, Ljava/io/FileInputStream;

    invoke-direct {p1, v1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 11
    :try_start_1
    new-instance v2, Lorg/json/JSONObject;

    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v4}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 12
    new-instance v4, Lcom/aliyun/emas/apm/crash/b1;

    invoke-direct {v4}, Lcom/aliyun/emas/apm/crash/b1;-><init>()V

    const-string v5, "userId"

    .line 13
    invoke-static {v2, v5}, Lcom/aliyun/emas/apm/crash/f0;->a(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/aliyun/emas/apm/crash/b1;->a(Ljava/lang/String;)V

    const-string v5, "userNick"

    .line 14
    invoke-static {v2, v5}, Lcom/aliyun/emas/apm/crash/f0;->a(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v2}, Lcom/aliyun/emas/apm/crash/b1;->b(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 20
    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    return-object v4

    :catch_0
    move-exception v2

    goto :goto_0

    :catchall_0
    move-exception p1

    goto :goto_1

    :catch_1
    move-exception p1

    move-object v2, p1

    move-object p1, v3

    .line 21
    :goto_0
    :try_start_2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v4

    const-string v5, "Error deserializing user metadata."

    invoke-virtual {v4, v5, v2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 22
    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/io/File;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 24
    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    return-object v3

    :catchall_1
    move-exception v1

    move-object v3, p1

    move-object p1, v1

    .line 25
    :goto_1
    invoke-static {v3, v0}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    .line 26
    throw p1

    .line 27
    :cond_1
    :goto_2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v4, "No userInfo set for session "

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    .line 28
    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/io/File;)V

    return-object v3
.end method
